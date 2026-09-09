Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA133526AA3
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950654; cv=none; b=S2pDRx4lETg5cDeEqkKRJdb9QR9sw0o6Wj3fnKm0W4t2ZNJ5DaOy+rZedS7wkLcVBPzpHzW/KACH2BA9bbKTWVMAoZNVq1JvnkMDHucOE3rv5TwrC9tESismRjDG0Ecg3JTZm6Oi6n4hOF+KeYrzixnaPJ4g1q0pdIRTaRoyxnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950654; c=relaxed/simple;
	bh=6E+kMr2lMBNGEqjwcL58hL7HxsxKflsZlGPjEvNauxU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2mtIm0611R0WKhZ1IPgEb+9qKoCWQTf8/WFz5y7GQkreLxd87bboawK0TZffyfPd9vJcsCDgNQ7lvWunbYl1uaJBn9V2ynzM970UGtUMUQ4bAKjQgOz9avM3UHkT3ekm9v/BXAcdqOJcVNISwSNbCH/GfJgJ4/5jNMJ5lB/WeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=zhJdbnln; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="zhJdbnln"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A554120704;
	Wed,  9 Sep 2026 12:44:09 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VRirY_Cgs2Xt; Wed,  9 Sep 2026 12:44:09 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1B35F20189;
	Wed,  9 Sep 2026 12:44:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1B35F20189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1788950649;
	bh=5FsC7thW9XEqMEuGRuMRLMJQbQCVjE+Jjea+aYA+D2w=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=zhJdbnlnfIoU8QFZuivYerSM2hQXZivSDj6MM5E2wbGAcw6EP/vRxBzi5TM4rZlF3
	 t04Zglo8dWckbsmyAbI4Q+AbJSyzY555hHSCHj7zGtSF+mn44G/pwbYubjKzfLFHfi
	 ZH/XuufCpl5jmO9GexvjFSUFSYyzpNvGN+G5E1u++ZOmCQbOY0/lzky6KbFk5E6duv
	 oVRg/oiUIRDwxjVP1hadCekcGk3OCzdNc8vOshU0S6VqchInGUF5G4/v7rdqCrh9C5
	 7GB4/g1gS+HEahGPq3hhHBAad/IS0Ob2gnCiF72gNvFQTjK8hO55ZAQRA+ePDmXUoj
	 hViGiXIKHSAww==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 9 Sep
 2026 12:44:08 +0200
Received: (nullmailer pid 351135 invoked by uid 1000);
	Wed, 09 Sep 2026 10:44:08 -0000
Date: Wed, 9 Sep 2026 12:44:08 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: Some clarifications on the upstreaming process
Message-ID: <aqE4eK2cqpvxqCQJ@secunet.com>
References: <20260907093020.2228346-1-steffen.klassert@secunet.com>
 <aqD-_cBnIOMEpxVh@secunet.com>
 <70d0048d-694b-4348-a6a5-de87a767b8fd@redhat.com>
 <aqEzoAcZ0uP0Kz6k@secunet.com>
 <83dd4915-e7a3-4c7e-91dd-adbea16450b3@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <83dd4915-e7a3-4c7e-91dd-adbea16450b3@redhat.com>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

On Wed, Sep 09, 2026 at 12:34:42PM +0200, Paolo Abeni wrote:
> On 9/9/26 12:23 PM, Steffen Klassert wrote:
> > On Wed, Sep 09, 2026 at 11:23:56AM +0200, Paolo Abeni wrote:
> >> On 9/9/26 8:38 AM, Steffen Klassert wrote:
> >>> I need some clarifications on how to handle future ipsec patches.
> >>> Since we have the AI-generated patches and patch reviews things
> >>> changed quite a bit and I have problems to upstream ipsec fixes.
> >>>
> >>> I have the following problematic situations:
> >>>
> >>> 1) Sashiko found nothing in the original patch submisstion,
> >>> but found an issue when I resent the patch with the pull
> >>> request. I think this can be solved by asking the author
> >>> to send an incremental fix on top of the ipsec tree if
> >>> it does not happen too often.
> >>
> >> This is usually the correct approach, with some exceptions i.e. the
> >> newly found issue is impactful (the new code is exploitable).
> > 
> > Are you willing to pull this as is, or should I resend the pull
> > request with the incremental fix? The latter leads to problem
> > 4.1 (patch does not apply to net).
> Due to time schedule I can't look into the series detail before tomorrow
> my time. Since Jakub forwarded the AI report and left the series in PW I
> assume he is looking for your replies to the AI comments - which is
> pretty much would I'll do.

It was a general question, not directly related to this pull request.

There were several issues reported, it will take a bit of time
to review the AI comments.
