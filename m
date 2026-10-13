Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B0A51990B
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902519; cv=pass; b=Ln+hex+tbTszDRs8q8ZFN3F1qdE0dYMGl3z6adIWzTaNk2gYxBtY3Q7gsjOlAJkdIZmmf5F3sfvpPqms8ZIWN5aswFBY21Tfdxil4YeDAYUTBrH/9pzZzVacfRtSt5ReeiK05Zkrxbd0QlludeWW9bpWEOp/aX6hEjsXB9jTsDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902519; c=relaxed/simple;
	bh=qUs7w5ACRHy3GOBHYVZOyK+3nLYWhsG5Y+p+Px/cmc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcF58O3FfdrHIJsKT0LOHiIMix1UhAvIpirvH3s6RBPw6WSRxvRIzy1b9T6Z47kPEef0h6D6yDsB/ZOkwv/PicRxXN6LE9IHeiPqQNtrTNN45L/5BE4Divj+J70XlwzLyBRhUxFheK/VxIF6UQOcHq11uORaH+1+mYBF6fFY4BU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=psPeLslh; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="psPeLslh"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6768ced47aeso2764454d50.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 07:41:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791902517; cv=none;
        d=google.com; s=arc-20260327;
        b=dXsGxCMhRYX1eYJ+yY6hI/h6K9HH2nT4pqiLu3Uhn/akZ12i6BTu/UHYQvvNJ8adr5
         zFaPFyXZm99OPD++wp64okVuXGtUA2b0FaNL7cUvbWvARNfEGRUCBwTVkiiiHkM+BgVk
         AmIMhLR/GzgAd56Q+01MiIUxHBfZactZEqbodWJk8UBLj1AIuKiE4PXM8ir7tHQQM/Ve
         slzSgY8TxfqUBNp06rEVuF1SDLImOHHMS/cMPI0y9lXIlALFB9fmaKCuvMfy1Y4zAq4L
         EW5ZZXdAH1XBmdXQvURvnrLSM9HWj+3gxYHQ7ZONoSeOZ79dF11ULMPiZPHOqrVjXW9i
         3Vvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=msz/OHbY6gDBK50SJeL3egmDDr6qQneSQ9CQTdw74V4=;
        fh=8FukAs8jluyYxtg0j1Wu+oqJkrTts9AsY4f+Q23eNQw=;
        b=W+KMec81nzQx4eOA6zZn4MeCxpY9zaQJbgZkAhe1bLDcsaj1U5fg5PNF3CUlDQieUe
         CxFQSfpN9CVwWENeEHWP6hzOe3tkN3j4fjHpF5lCqI4HFl/l4gIf0AibzjmQdObUDb9l
         GfbpcRh6bq2IZ+67+mnpEc0cHV7bVQeyuei9OgFjG6YW7hudr8NCQQFvdVE9AYIGbAJW
         7OJWfIF4kk0u3qtZy/1o/muU0zFnqpRmATXTFLT8Yn21W/CIATbG6MkF8elSPQSAyJsM
         EU/o1epvZ5pZpOtncMMay7vKVW04omcNWX2xy7KXKjKqzGux5v00z1Va+ad8bHuAhmZy
         OJgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791902517; x=1792507317; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=msz/OHbY6gDBK50SJeL3egmDDr6qQneSQ9CQTdw74V4=;
        b=psPeLslhw9nAfZZ0VGEkOXHwf+HPF//kKiC1Ym/+hztuQzbiD8jBo2tSJkW9IgWG0K
         /2c0bQS0XjIgA3HAhDo12sPidMsXv5873pIrEWY+s/dv3gX9Na464akCNPOjYlzTWrKT
         UZNVyIRII6rHOjDy8Ak++NPQN0TlUrKLnHjzpO3Kne35towMqAMP+saDXsLEaCorEnjI
         yIrNlXwbheNTTWUP1Xn+o2+sKaTwDH+b9PACUQ31omdj3QEycOV++7bpjq8EkCWSY9ww
         QFMS7pwr1CAbPOhTLK5C0I8Bo3LhgS2E9BYDNzbFL6jThnRVipMFoxq/KG1nEhcN9CaB
         EXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791902517; x=1792507317;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=msz/OHbY6gDBK50SJeL3egmDDr6qQneSQ9CQTdw74V4=;
        b=qAkvLaBrT2uIiupIstI0NIsLwZMGbc7f1sLVYN3OIQkaSh58STSsxxn1MNNCVukBcf
         ZGDRpmYFikHpvOupnFsL5a8u70G2dblHc2KHZVd6Wvo/DobwXk8HlNl+mRx4We0YqZcc
         c8FBaBvjejibuMyRMh+b/oU1S4NeAszFNYt/7x1quIEzflNiNyNEusa6qvFyQ+72QjfB
         PRIYcbkm1aD3VD/rCqseSvCPM/MRxy1VvNGWzsydGXXOaBJwpc1OSnO+Lul4mLVvVbhJ
         HH0slELP004FWt+ZAToKoGaIyO+8oatzd/DeH3nDo5sX8hm6wxGmRMFT3O3DkQcK3tQd
         vUNQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJPTfppBWFK9+9XDlzfL0L5gKcNEWWeSYgHETHYgyndJTSLm5SA22TfJK5HbU9Qh0FPK4mTBM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQCd4efbCjeTUll5D24jv9wz6lTWNzb9fYrjxPvbgwFFFReL6t
	AWUrvCeiieGF4hR9yeugCpeOujIgvM1ZQWs4UbMW7gtSjnNlcWYQFFEOzRZiMHnwzaSQ526nGwi
	OpUQKvRauNQyHkyJkBGVKoC9bSTInuz8=
X-Gm-Gg: AYBFou07Z6Feo+Wi+GA4IoNlN6E40BriK+GKpwXTUNgDy5rWTQzaxIGEyiMVvj9/qO1
	OGcSy02md5PaNpHf1L/0vOoDzNVm+89osIc7B2uAGgjQjPe0aQk+UZGt4hMpIvAd6UQXPmMaB/6
	tMAEF6d6Bju8RqmrKaGzzJQxnKcvgZi4pqJ23q7QYpX3VKWeX+JcjP6nDFtP6BHrp3d10s3wQym
	8XkFTrpFpKfQdptB2vNQ+SjGjxszATe6w47M5Nkv/uYfVd8d1snepYYpzWxqq/AEuHztR8tKNty
	NOIE01Qpenb/MLhK7EzT7wgFnjnS5e0sbYLactUmQirpmy/IqWER0MJXKYZ34zfbbSwVa+NG7zn
	agHBwJvKkrNZLr2OHOZBL43lSQNN+FiBZgdffzWcM0uCGVeGMOHV6fnrGEwoKjwV75WVmRV63Mg
	==
X-Received: by 2002:a05:690e:4419:b0:676:9115:60e9 with SMTP id
 956f58d0204a3-6793628f4demr2875284d50.90.1791902517059; Tue, 13 Oct 2026
 07:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791887415.git.mst@redhat.com>
In-Reply-To: <cover.1791887415.git.mst@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 13 Oct 2026 08:41:19 -0600
X-Gm-Features: AclHuK9vgLAAAJnijj2jNDp9uWMhQi6KN7iUpclgw57vpslbmAypj_7mfirQUWM
Message-ID: <CAF=yD-JhTbmYmHUkkruPcyvSWv0QhVeGWC=K=ZvvpMdkzA-jig@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] more virtio-net csum hardening
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, Max Krasnyansky <maxk@qualcomm.com>, 
	Paulos Yibelo <habte.yibelo@gmail.com>, Chris Arges <carges@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 4:58=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> Allowing untrusted hardware to specify csum start/offset for
> CHECKSUM_PARTIAL was not a good idea, because, if it edits the packet
> outside the actual checksum, and depending on the setup, the networking
> stack could be looking at the packet both before and after the edit, and
> seeing different results.
>
> Previously, commit 6785011f8b16 ("ipv4: validate checksum_start before
> completing checksum") validated all known instances where this
> causes the most grief, but the real fix is to make sure
> that either only actual checksum fields are ever edited,
> or the checksum is completed before the net stack looks at it,
> so it is always consistent.

+1 on the general approach of performing the checksum offload at
input, unless the input can easily be validated to be one of a few
common protocols. That greatly reduces the risk vs my previous attempt
at trying to drop.

Since we do not know the full extent of grief, I think this too should
go to net and stable. That would mean initially a single patch that
touches as few files as possible. The helper function in
include/linux/ip.h and conversion of existing open coded parsers to
use that can follow up later in net-next.


> This basically does this: checksum at ingress, except in a narrow list
> of specified known good cases.
>
> Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
>
> Michael S. Tsirkin (4):
>   net: add ip4_parse()
>   net: use ip4_parse() in receive validation
>   net: resolve uncommon partial checksums at ingress
>   net: account for ingress-resolved virtio net hdr state
