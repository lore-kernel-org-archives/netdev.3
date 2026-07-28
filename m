Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CCC2E413
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 01:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785202653; cv=none; b=RZHpT8hEGI6BHTA1F34ZTBZbs1D9dET//swO5gTupYYrrLdK1js0HNh+BXarYr3LBFUVZpmymnuxWIJ1R/SXr5eIKwEv2VENLq13wY3mRR/gegCSPX8nmf1ulzGAbPcjR6jDvBHDeSyTH2ag6rP7mrc3Sm4oP8oHekgxRx+hMP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785202653; c=relaxed/simple;
	bh=O9Kbkus4H5Hoe5cLw88Xx/+H6R4LTiHEVnMYnMlAG7A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aEkvSBD6+Fa/B/JqB/f4n3bT4dtLz3u2ansFwq/CnQE/0SY+c89uNHakTfXI/QzyE7n4M8vZEfIxrz/ki1bKy8A6yvZx259PhTey3QnJgs6kEGIGSR4QSRFmn/HiPc9tILlJCnF8E0NaVAXxDBaaTWCscHtQnX2cgr/7DI5qtdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuKiGs/G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuKiGs/G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5E81F000E9;
	Tue, 28 Jul 2026 01:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785202651;
	bh=mgjTdRWCZDUxjdoQONYGyUAaqU20UkAqWyNp7o++Rd0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IuKiGs/G+InNQ+iGD7OFuu3ASqU6pTfk1BoVwRb4s41Hi3lvT+aSEiMxbftqkXCIu
	 1p6i1Vh29dyJsTLM2AWDaVG1m0ozfsvgm/oyx3Hzu+Aiq+41rI4LQfzhL6ZCNy13yT
	 BxXb1oBRvgkwJVMr4yJgQvYzcajDzTwvhyeW3E2aRhyV9cijUec5EhfdanzhW2pEYU
	 fnKFj4nEjQtgZR/8KOkMrZi5wrvtHJ80uqPj+4wVpVOQlWIISBAUqMPUM2m32MHQLw
	 zzc+gsjkUMNZYJ7zdrf24Dv5WxefeHZcN/iffoeH9pT4TZ+gDxl6QBXfH1frVBc9xz
	 1KRRw9En/CQWw==
Date: Mon, 27 Jul 2026 18:37:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Juanlu Herrero <juanlu@fastmail.com>
Cc: David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, Pavel Begunkov
 <asml.silence@gmail.com>
Subject: Re: [PATCH net-next v3 6/6] selftests: net: add rss_multiqueue test
 variant to iou-zcrx
Message-ID: <20260727183731.1537e158@kernel.org>
In-Reply-To: <20260722203950.58550-7-juanlu@fastmail.com>
References: <20260722203950.58550-1-juanlu@fastmail.com>
	<20260722203950.58550-7-juanlu@fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 15:39:50 -0500 Juanlu Herrero wrote:
> +def rss_multiqueue(cfg):
> +    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
> +    channels = channels['combined-count']
> +    if channels < 3:

Please add doc strings for the new non-private functions?
