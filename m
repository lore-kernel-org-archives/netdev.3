Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ED61F938
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135931; cv=none; b=bakrV/usBWNYJseBMrY/U6ToaT1+MPF2ad4CXd7e5FsTlbXnEB5MKSfYbOWWzgwDjoeg9FYjn6aE25+R/ylctXk7lTZFkTZXHbt7IC8zXTUM3PvoijmWQRb7q5uX7c4PugK6pTjWWpf3u2zcWq1Rmy7OBje1nL+j1Ydm4nogwAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135931; c=relaxed/simple;
	bh=JX6mYb6A4EoiNPzTJCqji8ArUui4t8tLbY/Xs8Iz0+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GMYs/n4eTOs+oKLMgs/UcGhAG359JRtOmsR6fsR7Izhm4JRIvF4qVl6mmehQlcl0c2eLzhAaKZe5+/6oyVEecjHfXjjMhkmDp0t1z9x+3IKpt0lNK6LbNK++D69ooxWA5Wkoafo9dHObfde90Jm7CcMJONcPaachKV6Qm7fv2jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=iuTeeGW7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="iuTeeGW7"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e4a341d177so6078665ad.0
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 10:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791135929; x=1791740729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yodE2IxboPmi1/trJphVLQV25fxsZhiPApxOu8A+jFY=;
        b=iuTeeGW7sNSiDMF6ZdvS6lS73KkBMlZkUPEqn/1mjTM4wg8UQ3+Yw5uXhZASgVA6Pe
         gZ6h0anWvMYr0ea7hgrZXL2D/PFx17gzrjmlJ456Gxp6dQ9rkw+zou95uCWtCCRkRk8h
         1lkODEEyipPjl1g3hY1gg+UHE04x7EVfneauC3Kmq8Qemdg3uAAC3Xr6/x/61zim77D1
         BKuBH2l8tDEffxk91XVyCVaYvrp/K0jg8EimOWooeqqdBEoxMgqqK4dRD09UtnyL8mjt
         lNy9S3sK0wObkit3qQQnR1i2GNxAWedHkUznyZi7kO7MYH/EOvd2H/FjAtPM4zl5s85o
         QVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791135929; x=1791740729;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yodE2IxboPmi1/trJphVLQV25fxsZhiPApxOu8A+jFY=;
        b=E+1O9pbvvX3+GIdUboyVMV/aWybFhHa0TExDPub6ZB7aICuyQ06uml/kYizmvVlvUx
         KIWJOHn3gB6P+vvuMUc4PtVdHjrsyLAi0LKGCaB4CpFLm9xkLhv3U6yf+f8ELLfKRDfD
         013KjVvbkq8rdq7u/oLJ1DETHWdp6vd2+m8P0NNTsHkGjILPDYhGb6FI/QWgQNeGqhYw
         THWJbx09+w3G/Z3BFbVtTWDOJmRYsSIPwTS2WMcWpkav29yyJ+7cei1ykIBHanUOr1Tu
         K7WU9u4AnKl1z2XG7u5Bas85mcvHL4Vxec/+0hpACTRVsNW1pfrcwgpbmoIa8NdvRFpw
         5tLA==
X-Gm-Message-State: AFq9FYI+DSt5jVvZW1o2yBEptGCqs9m+tYQqCV2jR7/nAH27ilTdOTtS
	Hyeozh7fMb/wmhq91S3ZfraP72ggdsfR/uZI6ZxPqSdVBN17AnDTdJWo3pkC4aSKeobX0xY3kKh
	vbknvCHs=
X-Gm-Gg: AYBFou3gq69PCsvnSgNWJXlNmODuYMDsqSZjBPVCvQ9H3RYZRlusverJvO/QssQk4Tt
	AgDNh47eOZjsfM22p53j4DFABb+vQnPiexqB0SR9gFsk2u0o+yUNGU9N/wc3xp+Kc3QxPk5EnV5
	4vx3rEI7mefJkDtCi+Zl3myMuTWOdyjzzjudi9RNB118k1Ts81Z88P6gTNHeI3bstDHLPkBOQMP
	q1tQqK/P0NqWV8hcTsgXRZEotzksTrwpCtkP28GIWhc2oyLgwKugxYGMyg4WkwNUpnaC88qGi1e
	TX0u0/AOqUXMoJSINVZH4yxeZuVbEY1uh5N7HR2MVfoHNNqlmuHZHzO90O5wWEHiPRsrgO0Y79o
	wpQkgs8Yp6+H0GYZYTW/32WXcJHcpt00TPjBycPN79Rf0VwKLdsJbmYw+WilDtx2LbIsjmTi22A
	K4DYePsaKSD5vjMxJkoaa9tur55TYlmRvCpcrFUn7SC0mrh8PF0E7TG1fb2F8TqhbPo6BTNZmGs
	z4iqmkJwdrf5gErPVmRvK9zE/POIuYc8LvGoMsrSPfNusvK7D2i
X-Received: by 2002:a17:90a:e7ce:b0:39e:1310:cb36 with SMTP id 98e67ed59e1d1-3a7871801famr3993911a91.20.1791135928964;
        Sun, 04 Oct 2026 10:45:28 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78e5fbf30sm7412249a91.16.2026.10.04.10.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 10:45:28 -0700 (PDT)
Date: Sun, 4 Oct 2026 10:45:26 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Christophe Burdinat <c.burdinat@ateme.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [BUG] net/sched: netem: delay correlation has no effect
Message-ID: <20261004104526.56a61ca5@phoenix.local>
In-Reply-To: <PATP264MB7825D08FBDEB801422FD6EFD93892@PATP264MB7825.FRAP264.PROD.OUTLOOK.COM>
References: <PATP264MB7825D08FBDEB801422FD6EFD93892@PATP264MB7825.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Oct 2026 16:50:07 +0000
Christophe Burdinat <c.burdinat@ateme.com> wrote:

> Hello,
> 
> Context: we found the following while evaluating a QUIC-based protocol (Media over QUIC) with netem-based network profiles from a 3GPP study (TR 26.934), where the reordering caused by per-packet jitter makes QUIC declare many packets lost and changes the results substantially. The following report has been generated with Claude code, but humanly reviewed.


Thanks for the bug report. Will look into it but do not expect anything soon.
This code is over 20 years old, and it may just be you are trying to use
it in a way that was never intended.
