Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901355;
	b=Hq431Knpx6Wln5bgW+Fmxwzb8vFL85mjGmKI8qhX/fDXOe0NKBdTZMPfJ0vf+3RHvjIX
	 KyEtX+iOuRxY/kUbFBXyEQeBf/YRgYRix6hUE3t7uMAAEpquaZZUJ409/UAY2srnC+082
	 53j4+Ai0+uJlVkgnivFhiK9Mogpmycyf2HbU7cQqqbbGMFReP/dfY/Lk7BA6zkwYQfu7i
	 ufcWC636Pqd3lf85KhU7w5Zrw/4ruvQ42k8JqhHnPXH/1lT2zrSgqt823puVCyPhNr4Tk
	 ig/SthUC4L1KOpRNKE4WcPkRMqC+6Os8Su1LxF0PrrcTSsuhyg08R+vSD36SFd85VOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=PT8+knV5liWy29BtrumvMiHIoxRWXb5eMMdqevncVAE=;
	b=qXO97ftIZMws9CXn3U0Wq9GMUAWbZaASC2g5xevUC3M6JcofN6iSgYM7CrzQKUFDT2pC
	 AGyRvW35hwbDc0QqB1A/XPyFvO34t4iHZk5yFtbm/+S/bwfocjL1Ql8LPADmAzfr5RvHu
	 sovLvW+/iUF3G2NLkZTk4/aVpopJAy29QS11Yr1XHNT4MpjZPvCiKAkageNyuQRh90lO+
	 0m5W4risJx6+c6U3DacZAvnQIk27PV2STnWjnTkiKdCcYEUW/1MhvKUw3gD65UN2X4Ltp
	 nM2EPE9eICl82h9L6zN7rWy9ZOW3aazvZw4KpYw8m7i/C8MrQpcMs9KoK/Fp3BJSUXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gi5uigdr;
	arc=none smtp.remote-ip=74.125.229.138
Received: from mail-dl2-f10.google.com (mail-dl2-f10.google.com [74.125.229.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAB4606A328
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 17:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCAB4606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gi5uigdr
Received: by mail-dl2-f10.google.com with SMTP id a92af1059eb24-17c2de6994cso282764c88.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 09:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793901354; x=1794506154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PT8+knV5liWy29BtrumvMiHIoxRWXb5eMMdqevncVAE=;
        b=Gi5uigdrYHN5rA77ayiD0aV/+kPtnwiZq2VcYinUAKrMWWhGMwvJ6ckGfGqs7dqoVZ
         MAT3/y0LALIyPtT+pg52bJpy5nsZWY8qLzhr07n9YhDsldJWyg0P3rjaNjZCc9ntZXKp
         34qXrp713xEK2H8v9TuNgqRXM7yDR/D96VFWca1T7zJG2qMPy39TUHfTmv0XoiM9c1U9
         CtFy4S3TEYUOUcjK3kwOTfiTW4C3iuJgStNLb53U3kvm/1muJi1picQ9Vh+pUU03akr6
         HtSDoYxKdM2TYf9Ar95rPWT93gStbVqFrdPX9Z0a9aj6WJxEqzmbkdbqjkFBiQE9KpoH
         qyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793901354; x=1794506154;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PT8+knV5liWy29BtrumvMiHIoxRWXb5eMMdqevncVAE=;
        b=r/XmVTwZcnxwPn1WBLJ6KzErwFQaBVJZMlGbWqvAiFCsSGITeBwV4G48NnwsHvt+6Q
         +8cih7D6Vs4d6iQWsGH0mWhXvZs4Lxu5jH7O3FnQCXx4AJvzmXBL6GdIHX8b3Rl4a2su
         mdSn/x7J654KPETjMSCtTJZgpReQwjMmftE0X1NtSN+69TZTzD//vvamsat3x3rIV5yo
         oW7mYGNiCMY0Pr46SFEjtIV0PECSWD+8X9UUAcNuuMf2ybdKsD4hcTrC14yFxtg31I+z
         hf2tSrkK5D5kUCoMLIKwjlp0/mE310GyRSR6QCnossQQ7AvqljxBzN2CWysNRvEu96bu
         evJA==
X-Gm-Message-State: APuU4Z9sNvG/s0zptG9rtRMfgquEh3yZ6+EPclmVHgBot3KSmm8O5mms
	olS8VHR5Xe6Uwh75yUN4AGGl7KALfQwp4LmTvpXnlKYp7fxfMWr1pell
X-Gm-Gg: AYBFou3MvHZpJEzs2q2lwXw9rl5Ig3e9yiYK3DBViLP9LQ0BVfLnUVC+imxe6n3hOqz
	LkfAmVgPtnA1Cchj3HA0GKktJEVeg9Y7NlB8OW+soSzaVG2u8Sc25QqQbOOXgRiIjb78vHAiTEo
	e1o+fCKxGOA9AjMhnovMhUgGNxmEfjwoR9xbZIeh5NIsVjGm/pbTAARctaatve+16OjE4a6yg+R
	DRmJn7lyLmiOFz+kgrBQoETEOdIuHrfHmdPR5mi3vqRiJeLO8lFsVxgqtehdpqL2kUgjqe/gSyN
	RI1hqA0GlHxKAgzgG6Aa16wLX0ZRHYBgXNlgVn9s6fRLLx35NN2nKtbdCYOUFwqFjCSbXYqt5Gc
	vVxrBqCtQ8+35v4pAjKH/Gi4k3hqO24kPFUjK9fAvZTIg88vkGiMRMRUZ6sTnNDt+Mno0A+eQOP
	vaXa05y7+kOm6zQtVQ26PD10oNnWAi9vbsXqXHQlQ4mIRfwSV4hiXar3fHRlSzt2GdMvRL4Anh7
	tnXfiKmCbHqbd2PfQcCw0j5AUOWY/9eoiHqhwOeEtKQ9+ttYQXPRVS1qzKoRAksLVkQd7jwEOWL
	y8SL18vnm5JodPzbwpVFJg==
X-Received: by 2002:a05:7022:258a:b0:18c:e014:6f1d with SMTP id a92af1059eb24-1ac55f2d3cemr35929255c88.1.1793901353699;
        Thu, 05 Nov 2026 09:55:53 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:6a::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25100667esm9741999c88.19.2026.11.05.09.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:55:53 -0800 (PST)
Date: Thu, 5 Nov 2026 09:50:21 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, edumazet@kernel.org, 
	horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, sdf@fomichev.me, 
	almasrymina@google.com, bobbyeshleman@meta.com, asml.silence@gmail.com, 
	razor@blackwall.org, daniel@iogearbox.net, leitao@debian.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 7/7] selftests: drv-net: devmem: TX from a
 hugepage-backed dmabuf
Message-ID: <auzBkdVHfk33JlF4@devvm16445.scu0.facebook.com>
References: <20261103235152.1904727-1-sdf@fomichev.me>
 <20261103235152.1904727-8-sdf@fomichev.me>
 <51381a84-de40-4d4f-982d-9585a2344119@nvidia.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51381a84-de40-4d4f-982d-9585a2344119@nvidia.com>

On 11/04, Dragos Tatulea wrote:
> On 04.11.26 00:51, Stanislav Fomichev wrote:
> > TX net_iovs are now sized from the dmabuf layout, but the TX tests
> > use a regular memfd, which usually keeps them small. Add -H to ncdevmem
> > to back the udmabuf with 2MB hugepages and a TX test which sends a 3MB
> > buffer from it, so that frags end at and continue past the 2MB net_iov
> > boundary. The payload has a 7 byte period to catch offset errors.
> >
> Why not add a test with a BIG TCP GSO test as well?

I hope we eventually will have all this tested on NIPA with a "perfect"
config. Here I did not do big tcp because I wanted apples to apples.

 
> Nice improvement btw. FWIW for the series:
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

Ty for the review!
