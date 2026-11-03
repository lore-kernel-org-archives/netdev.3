Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674183;
	b=GKOhFg+Yb3Wt6cBL8U1Cl59/RKoRFjQXeXHYTzPET7ffKRAk0HLBM00I7NtNmOsiU1Vh
	 KoIBLnAM+w/u8CIk7Ry/vm7i+D9KM9YnXikgjKTjSEBCEflHIG+w3pzh0VYlwUIwoxaRJ
	 HZLRMDs+e1eHgioVYs5tQDpSjodXKBmApfRBZ5/EetZjCMN0swFdQNOttsbUuW8GpFOWx
	 v4FAVfWekHBDQ811mu3KD4w6ihVloDK4GefxVht8StLCquvfW6uJ47BT/hFCK7QIW92iC
	 Ga4joce534L7Rbb4OP/plECBlzh/V8eyVYICYUrhMqZEn9g5WSQuzWQ8ROmLJu339eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:In-Reply-To:Mime-Version:References:
	 Message-ID:Date:Subject:From:To:Cc:Content-Type;
	bh=omm1L5nAleN8oumDlQH4AJxe0cckZCmAcJozczWP8vg=;
	b=qtDVQjfpV8sGxlENhOvnSNFGLf26cpvZVsTUlhMY8ZAu4ngNZ6FiyzYTduzFMYSwoRfS
	 cPKrZzwREVxT+AAwCJ0ZKOhcdF/MYVl9tAOuv+A5pQVLOb/6hQTWa1BzwVR/HH0hS/c3T
	 MdF0wBpf6WBKVX37RbMNGje0yPtRRJtozcFjspFQ6hOIWEOulSp7AHCnHWlgOtK2Bs+2I
	 7/FKkv5jRq5RcR+MyI9hrsF4WdNgRm+70LyOCEV5anXPz5kPItoycT9LNBTsa6BA4mUVP
	 lcm7lHlOlx8W3cS0uY5Z7V4SLxaKgsSVx8bVZ2zSp6aL4/it4w3JQ9iAlaEz2/eRJNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MragQKda;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08936606A332
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 02:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08936606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MragQKda
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30bcb065bfdso6896351eec.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 18:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793674182; x=1794278982; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:date:message-id:references
         :mime-version:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=omm1L5nAleN8oumDlQH4AJxe0cckZCmAcJozczWP8vg=;
        b=MragQKdag5t4MXJomcMGA9BNSS+wXTKROm0QocLe9DfrPuoBEWX5M+mdmXyeW0yAkW
         boBQpAHUINTj0J9h3yCg0LdcnLcwROu38w3Iz7K7cRI/iBPgstRhjwlQh1GFvpHArSFd
         r+YvTl+ylLXZpQ7uznnCt84CTV+avjzNMiQlt1jOpFWonx0BRt1NUt2KsYhKzXPn82r3
         p5CeoHiSRZxfHqEUw4YR/cnxP9PpzO0U85CHliRLDVBTF6M6U74JPfJgDfJ6EyZIM4xR
         wi9BSEvh1V4BPgnPSnV82kSd6sdclT9tGCL7yaGvQMjwWtPDQGCcu6a0O0iOEtv96kCZ
         2+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793674182; x=1794278982;
        h=content-type:cc:to:from:subject:date:message-id:references
         :mime-version:in-reply-to:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=omm1L5nAleN8oumDlQH4AJxe0cckZCmAcJozczWP8vg=;
        b=FWVh9/kfaX5vo30SM4T6K3YJj3VFvZ0ogzUfAglFbyTVGUBVGLXHOG8hLZQmorAkCB
         sjFR09OlkW+lPhyiM7mtBhwUo+aCsAy0oCNSPxXD1McfakcbX2oSwP46O8zmtjrpK/vO
         3zzdUtRnBmyldIZpH9UHI95jNevpJy6z04ZtRL9KAe/aAMgXhPAPgAFumN/nBp95v5DW
         aUhio6q20gb8HAOuNeVi0WCKrxv/Smhr8XS3b1IajFWg7TgQrtQG28UK0tyR+LYlqkfh
         3r4QWoJyHFRGkT/h06QXYFRK9FmoQcKrD3Huwv7+RMVui7uoSnv39q45WdxzDdl271LB
         W57A==
X-Gm-Message-State: APuU4Z9yS6TKSGwth00WSB5mNVJokTY34av5tX4AvGXWpVmqE6Xfd4E/
	nL2JLasow9fDL+icQIMEluYCOfFHCJP5lrQvEkr744E0PVJtOpMLJVMq5Fa5JeOUbz8Jk4KUy+a
	hiAev+UPh0OFY0GhuxRvcngFDsQ==
X-Received: from dyrv19.prod.google.com ([2002:a05:7300:8a93:b0:366:fa42:4aea])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:4154:10b0:369:f4d7:19fc with SMTP id 5a478bee46e88-36a424988abmr20697196eec.41.1793674181615;
 Mon, 02 Nov 2026 18:49:41 -0800 (PST)
In-Reply-To: <20261031162804.1893-3-maciek@machnikowski.net>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261031162804.1893-1-maciek@machnikowski.net> <20261031162804.1893-3-maciek@machnikowski.net>
Message-ID: <18e4692a3491af8c.3137322e32382e36372e3935.158ea9.0000sendgmr@google.com>
Date: Tue, 03 Nov 2026 02:49:41 +0000
Subject: Re: [PATCH v11 net-next 2/3] netdevsim: Implement basic ptp support
From: Mina Almasry <almasrymina@google.com>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com, 
	milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch, 
	vadim.fedorenko@linux.dev, horms@kernel.org, 
	Mina Almasry <almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, Oct 31, 2026 at 9:28 AM Maciek Machnikowski <maciek@machnikowski.net> wrote:
>
> Add support for virtual timestamping inside the netdevsim driver.
> The implementation uses two attached ptp_mock clocks, reads the timestamps
> of the ones attached either to the netdevsim or its peer and returns
> timestamps using standard timestamps APIs.
>
> This implementation enables running ptp4l on netdevsim adapters and
> introduces a new ptp selftest.
>
> skb_hwtstamps(skb)->hwtstamp aliases with skb_shinfo(skb)->xsk_meta in
> the skb_shared_info union. For an AF_XDP generic-xmit skb forwarded to
> a peer with RX timestamping enabled, writing the RX timestamp into
> that union turns xsk_meta.tx_timestamp into a PHC-derived value that
> the AF_XDP destructor (xsk_destruct_skb()) later dereferences as a
> pointer, corrupting memory. Orphan the skb before writing the RX
> timestamp so any pending destructor (e.g. the AF_XDP completion) runs
> against the original, unmodified union contents first.
>
> Co-developed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>

Reviewed-by: Mina Almasry <almasrymina@google.com>
