Received: from a3.inai.de (a3.inai.de [144.76.212.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD49F442397
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 20:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.212.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788293287; cv=none; b=A/TGY0jNb2G5v51+ADW64PKHbfopUAULgxfWQWQdSoscbsyQEdL0Domv3kkIm5YefbFbfccmOIml7EUhe+w3MG+xG1bMvljf7IS2B0nlKMPyAo7pJt4PfE0IDw4DaMCb2dyDEBa33Oiu1R3xde1K9Ah/QQdJcrynajiV9KwnFvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788293287; c=relaxed/simple;
	bh=0oy6QPlj59QA1C7zp2uJBWt08f++HVph/Je/Xh2d7qo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jdBYWemUwkeI+e7jAEvt4rVv+YpdaAwiB3PhZZyGPascB2sh+PO0ZD2aaLh+K21qM9bvSSZGYL0rYi6pLV9fTms0yvqUCQwHVBgTmrhY9A/zg5xhdIXMvPMBwi+gdDyBxb/UukKSAZMYaX1PcFK08OhBkn6AVPqcyOJ/2xrHAfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=inai.de; spf=pass smtp.mailfrom=inai.de; arc=none smtp.client-ip=144.76.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 25121)
	id 7F1C41014C131B; Tue, 01 Sep 2026 21:58:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id 7CF561100AF010;
	Tue, 01 Sep 2026 21:58:38 +0200 (CEST)
Date: Tue, 1 Sep 2026 21:58:38 +0200 (CEST)
From: Jan Engelhardt <ej@inai.de>
To: Stephen Hemminger <stephen@networkplumber.org>
cc: netdev@vger.kernel.org
Subject: Re: [ANNOUNCE] iproute2 7.2 release
In-Reply-To: <20260817193804.46fb3c18@phoenix.local>
Message-ID: <r48321q4-oq2o-np25-s511-pr9s68ps3o05@vanv.qr>
References: <20260817193804.46fb3c18@phoenix.local>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Tuesday 2026-08-18 04:38, Stephen Hemminger wrote:

>This is the regular release of iproute2 corresponding to the 7.2 kernel.
>
>Download:
>    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-7.2.0.tar.gz

This leads to a 404 Not Found-type error.
