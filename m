Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598F936215F
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786953181; cv=none; b=Wlm5BmzAldVN094K9GvLa0EQpuwsySJ4aCcsTzxkyJGj03gKKXotSgrcqBBlV4suEjIC9dOkJwZkRxTfEOVylOc4yaFh9XCO1mEW3GpQRBObdi/J8RBvrmfzy6mkdyc6cjioRn9Nf4RhJz+T1Zc6AdwFCtMMPMKlzG6tENZErRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786953181; c=relaxed/simple;
	bh=w2q5iFrTGhd7hMADLJAEW+myiQf+U2lQCEg1W7rxEEc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jetg0s1rwSWVq8QbRXQAH+CfiTX/B5Eezl6DxtuXw8vD6hFXxAst+byJ6cYY/9uPY1JU9wMiAtq/t/ec73kyYP9FhWf/dVcXQ6Wzsl566n3VV3qpHLiB4/B022QTd9Y00jXf9WGtUz/RkBQkBbdS6kbgLj6UhlxOCNhdQXD7X1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=lrMNzdaB; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="lrMNzdaB"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 7BECC2068C;
	Mon, 17 Aug 2026 09:46:40 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0mXa471gTPBa; Mon, 17 Aug 2026 09:46:40 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 0F6B52053D;
	Mon, 17 Aug 2026 09:46:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 0F6B52053D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1786952800;
	bh=w2q5iFrTGhd7hMADLJAEW+myiQf+U2lQCEg1W7rxEEc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=lrMNzdaBMrXjiZ3MFTIvORV9GTaE8nzDYycJ2Q6+MqQM7F0O1tMsex4oH+JVKQcPz
	 N1+DTzyxgXBe+qUProJmt7EIQwJHO2k/dvQ7t70W3XNRAEhH18awyV1PTM+zm5hwHz
	 Pu6ftZXbe+ji3wJwGRQJBUWVt3DEQB/E9SRskBqnifSXhZFxkKCm5n/TsNyLp0kt9Z
	 BKLJG84vgeU7jZoxYOtrQMmiQzOwL7CxKhJ5Mxa0wvTP7MeAh7RWCZziMIQnnCVRUL
	 5FEzuM1WWJo5nw7yqtn/FCXCuEf5AVsD1LryyZAQMU+HeN6usHzvKSzJFWCaex1+Yy
	 ILmfkCcIQvKDg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 17 Aug
 2026 09:46:39 +0200
Received: (nullmailer pid 2414916 invoked by uid 1000);
	Mon, 17 Aug 2026 07:46:38 -0000
Date: Mon, 17 Aug 2026 09:46:38 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>, Maher Azzouzi <maherazz04@gmail.com>
CC: <davem@davemloft.net>, <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH 2/8] esp: do not unref managed frag pages in
 esp_ssg_unref()
Message-ID: <aoK8Xl8uTm4MW2Mr@secunet.com>
References: <20260729065035.1591985-3-steffen.klassert@secunet.com>
 <20260731021544.789075-1-kuba@kernel.org>
 <anDIQ9-8Sf_6StfZ@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <anDIQ9-8Sf_6StfZ@secunet.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Mon, Aug 03, 2026 at 06:56:35PM +0200, Steffen Klassert wrote:
> Maher, please look at this review of your patch.

This patch is now reverted from the ipsec tree,
please submit a fixed version.
