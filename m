Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793612158;
	b=fRhHzO3x/ZkEYEwx5zxsDfoYfIcBIeu+sVOSaVFbJDu6+qXlUAvLnSXQ1PFz1khWEn0l
	 Lm0moHP/T0cB2Xoaahu1A6li6bt1/z8mFe1n33isUZdg3gTn1GUt+1uzSFYVp0NBF7IWb
	 AW9zUvjol2y8o0nfZG40zVhYWSdLSJB9cxMVochXGk/XNWxjbC968Mwnp7V+XSDA4jhDA
	 rGNAmcD8fwTSGrat5yg+sODX9ix9abdLqW23oBZCcFyLciuWG4TMdSO6txh/MNWh6NSrC
	 3H8ivLr6t5g/uqRFcufWQPpQFWGIlCmFag1hbmAEZ63QbnzN430bWzIWKuSO5ZQARzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793612158;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Mm9UAeiTDrhCY7oe9mnBBjHCOX4kZjsSHaPe1K0OWSw=;
	b=WY14pizsgK6wQCzn7vjkHykFij1foc3msc79JWkOkE/HsuGnP6N1hKH7a4OmCnqBqAMt
	 UjLChxy+Y41p7wMFA0PtMfQ27aApHLeoDpOEuIp3f5FI0AuxCsJaoI0gc7V6H4r8HhcHK
	 Vc/pokAVl02x25gC/3SnpYFNvsRG2K9CT+IFNb8hq1/hNag2bBmocqeDII9oSzdu6ZFJN
	 A0Jw6CEiNOHqwPxoUczFuG1BrjeBNO4aMcAWDNFymGxXQ6oHXmF1dLZ5hKD40XhrXvyzt
	 +070/dbcK9iGu2nnyj89VOFklLwwtSRbm/D3yCHTgARETizoCPcya/R7O4ZTLsRuE7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UFTkJ+mv;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nGt8834H;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4BD606A336
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 09:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B4BD606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UFTkJ+mv;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nGt8834H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793612156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mm9UAeiTDrhCY7oe9mnBBjHCOX4kZjsSHaPe1K0OWSw=;
	b=UFTkJ+mvX0cSyL7Ru/Ychv8nd/tsyjr4F7N4I953A4u1L4VaNQXzJ2qpFhkAnClSBDjzeT
	KVsPG/QVtBHzCgKP9q2Yi7TKljoYTf0KAWiMFebpZLFOBqMSM5cjJqkM+3YuMSBUMmYgXC
	2lNQMWxGLMQrxzxzhLG42nbu2PC7bZg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-jDWiMIyPPS-X8eiNgyprAA-1; Mon, 02 Nov 2026 04:35:55 -0500
X-MC-Unique: jDWiMIyPPS-X8eiNgyprAA-1
X-Mimecast-MFC-AGG-ID: jDWiMIyPPS-X8eiNgyprAA_1793612154
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a214a5f8a1so26120055e9.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 01:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793612154; x=1794216954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mm9UAeiTDrhCY7oe9mnBBjHCOX4kZjsSHaPe1K0OWSw=;
        b=nGt8834HJ1051BE9IIkxb1iFxH6KWri6OHygXgQ9dIsLe7HCfs+dUJNAhiqrHDfG+F
         dRLgQ32Al/xfeRt9FpMVJ/H5c4wR/74XwkDcukw7rqfh6JUElkHalS4iR1GklHni2HDc
         c52cgMxwXRZD2piV7tXpqWUalyrzUJY6pXw4uRlTbQ0riCFVMwzUx/PM5+U4ZQwEXY4f
         7W2SjjvFM5EoUXqHo7CKTHabky6ubWWdVV/6YDnimS/RVi2Ox7NgkRXujCzv75oJ6jGx
         ehHpZiURKYBj4a+80alZXqMKmUpY3V3+7+C+iTRIg4vAYY3myREErjY7ZTq0yrDR5LAi
         en2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793612154; x=1794216954;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mm9UAeiTDrhCY7oe9mnBBjHCOX4kZjsSHaPe1K0OWSw=;
        b=D6ThL6MUKUwC66PxVcaS5Q8N74eYgBdsL3MTqqSPtrCtnjWbAfUeI/ufrqbIdhLSFd
         5Rh/5su1JWjZYgZNiKFgP7nV9AJRF7g4PkqtqKLFjDOeEKn0Gfi+3YP4oAAPNJ6sJVem
         w8M57EcUZ53lO0RavOqJ70znnQ65Sw7CcqBT18sKV1yEMV3yfCxrE3I1ufz4o5QgSoBQ
         AzT/xzZjbr7d0ZytA3MgLD4oH2L01T7jShqGAIHkjUCNJuOEaX1b+6LgS6UoX9rv8PHr
         2OYMYkLl7wS4xR5IwiVSidXsJYxyJdYlE3j8uG6iLaMdfhwQ8cwtUKeKR03DYXlpIain
         EPnw==
X-Forwarded-Encrypted: i=1; AKwUvBzZssQoSuy2AOAJ9uh6x0f/17S7gPll0ToyIDly/CRS7aXTq6gtbJlNaUVRNVBMDeFPcdO22RQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKRvAXEcvw8PM94SEFxb5SurNNhWGGlr9/+oRZEnEeoZ41/b0B4
	inGhDJAAki4YoD3guUTrmK6W430coeyRmL4rnngDCn0fcANzHNpxqQH4xV1siQPKYPn+DXluv9C
	DcZB8ee4w/RG0lXyrwQQc7q0S/a/OHPfwsZIBRRZN5xhp9NNL9GCYsGcgAg==
X-Gm-Gg: AYBFou1+FSqDjVOH+3iUSWiChBn5rIoOhUg3LwjFdNmlHEn3SvBrpiHKHe/GHW3B7oK
	ntsJX7emXHo1fIllQXv7l5XQKrct6LRfRE4D6cVwQINNUl/DC/4xLssrVpwMwI19/w2TpWPNobZ
	+co6wnx1X14CZifz79lIOBmfheCh7i1DQwjHQnzOVuvIewij1iPPx7X4hYhh2bLglNyRnctXR/4
	5AYPU11kjb9UDtatUOO9+oA1BS3uCif6UUXaKjOyVdep6oKrafheqK28ud5osk/fZfNfCQ1nff/
	ok6XB/5VLARaCXpU0sRvjtkdBoafS0ofPnkDP7QbftN0A7dq5xqSLFaoaxdxff/tzaG3dqoQAMB
	s0btMgkceUwdwy7HFybRZ00QqB0n6z/WkZTB/M9BlUw==
X-Received: by 2002:a05:600c:5397:b0:4a3:5991:719 with SMTP id 5b1f17b1804b1-4ac1899353bmr216599255e9.31.1793612154070;
        Mon, 02 Nov 2026 01:35:54 -0800 (PST)
X-Received: by 2002:a05:600c:5397:b0:4a3:5991:719 with SMTP id 5b1f17b1804b1-4ac1899353bmr216598595e9.31.1793612153380;
        Mon, 02 Nov 2026 01:35:53 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1501:b100:9ea2:fd21:b361:8dab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6e63e0esm335169085e9.12.2026.11.02.01.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 01:35:52 -0800 (PST)
Date: Mon, 2 Nov 2026 04:35:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH] vdpa: fix typos in comments
Message-ID: <20261102043526-mutt-send-email-mst@kernel.org>
References: <20260904104440.18772-1-hemanth.selam@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904104440.18772-1-hemanth.selam@gmail.com>

On Fri, Sep 04, 2026 at 04:14:38PM +0530, Hemanth Selam wrote:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>  drivers/vdpa/alibaba/eni_vdpa.c | 2 +-
>  include/uapi/linux/virtio_net.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
> index fd6fdba46094..6bb5f6ef57cf 100644
> --- a/drivers/vdpa/alibaba/eni_vdpa.c
> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> @@ -273,7 +273,7 @@ static int eni_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 qid,
>  	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
>  	const struct vdpa_vq_state_split *split = &state->split;
>  
> -	/* ENI is build upon virtio-pci specfication which not support
> +	/* ENI is build upon virtio-pci specification which not support
>  	 * to set state of virtqueue. But if the state is equal to the
>  	 * device initial state by chance, we can let it go.
>  	 */


given you are bothering - built, not build

> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index 1db45b01532b..4a458ebb2567 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -316,7 +316,7 @@ struct virtio_net_ctrl_mac {
>   * Control link announce acknowledgement
>   *
>   * The command VIRTIO_NET_CTRL_ANNOUNCE_ACK is used to indicate that
> - * driver has recevied the notification; device would clear the
> + * driver has received the notification; device would clear the
>   * VIRTIO_NET_S_ANNOUNCE bit in the status field after it receives
>   * this command.
>   */

separate patch pls.

> -- 
> 2.48.1

