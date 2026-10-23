Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790166;
	b=ocQqgBRh2LQsx2GjjHH1DevW/qq53D7qH4d87frjXoORq2bFlbX3579KKDnLnflkxml1
	 8vsyg/zPTz9l75L5Do9N5BKlrWqvkhsrqLBzB6z+HG4R0C2KTExH5c9BIAP5KOjO/6Th6
	 GwwDBq2AasWbaFh7EAMwtPzYH+avTEWg7BEhx+Jg7l6SRx+bJmr7HxVm5K45rW2mk+tYi
	 zGtwudrAa8yM9MyDrsbPpGeGjB+rzgc36njI9b6nhm0T5WO2u9dPg0J7O24s8cH6GNtE/
	 p+ps0/Yp2//FtgI/aPZh6zLkyE35rg9HUTmy0uWswLVg2CrYGSDwwdRy+3k28+/K6ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790166;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xTsiCZc657L7oQhql4ts4mXSow+otBZUp5bcJ6kNE4o=;
	b=44vQp+dTB9gjQ+zJz/LN9k7y7U6pg0T+IOuUEd8Ec3YXC54MGCTgJjRMWldW9rFnxOb0
	 M2Fw+Qu/jnURbzqOnWtFMWOqW1mtDUI5W+x1O5qdnSMJCIxZe2cBJBW44D/yTJFn928to
	 Rzzg+S8E7jO7Y7KVUItj34E/70am7LO6bwDJ1BGGZCE/BzFLGEdvisi4agU7mYKpZYD1l
	 f6uzdzxxJfQ6KrpUuk0EN6UM3/xOxRUUQSdO3UJcfEBbcCS/Unaraw1lEZifJg7RtgAMM
	 yQnGNIKas5xbvA6tvii/DiIyyTrH9dfpDX088gb+kNIw/xdP417XaT5GXbV7LU7H1/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cy8LBVSs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78588606A31A;
	Fri, 23 Oct 2026 21:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cy8LBVSs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15ED91F01825;
	Fri, 23 Oct 2026 21:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792790166;
	bh=xTsiCZc657L7oQhql4ts4mXSow+otBZUp5bcJ6kNE4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Cy8LBVSsmQqXxdWSmyfYBSMocERiuZkmZrhZ3GgNZy/TlkPKDWRhfX0zn20CPDbzI
	 WIdiQKMZ2IJbKgkYBao+D+178EIqJMAcXH6k4PHgvbidXqs5sPk86HP9E3zLzk7MeI
	 nhK7gY6Cy7f1LHeMgsLdRhKzrMNJ4dgbnBPAyUFIdwP+m0ykPCh4QRf2iep9dO/2Lb
	 daapglSqminHk5rg0REH/gcrR82lwucsaJuaw2Ftrc01T6Rpf0ngQovjew6B5K0qXj
	 8DagkkUoACj6VDRfMd8rjF1NEdMFLIGrt9a5F3W7SWpeTCUpXMq6KnUweXB46R3zST
	 ZhIuJ7FqP+yGg==
Date: Fri, 23 Oct 2026 14:16:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?w5ZtZXI=?= Mete Kaya <omermetekaya0@gmail.com>
Cc: netdev@vger.kernel.org, oneukum@suse.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] usbnet: fix EVENT_RX_PAUSED race in
 usbnet_skb_return()
Message-ID: <20261023141605.74390430@kernel.org>
In-Reply-To: <20261020153044.18828-1-omermetekaya0@gmail.com>
References: <20261020153044.18828-1-omermetekaya0@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Oct 2026 18:29:09 +0300 =C3=96mer Mete Kaya wrote:
>  	struct sk_buff *skb;
>  	int num =3D 0;
> +	unsigned long flags;

reverse xmas tree ordering please

>  	local_bh_disable();
> +	spin_lock_irqsave(&dev->rxq_pause.lock, flags);
>  	clear_bit(EVENT_RX_PAUSED, &dev->flags);
> -
> -	while ((skb =3D skb_dequeue(&dev->rxq_pause)) !=3D NULL) {
> +	while ((skb =3D __skb_dequeue(&dev->rxq_pause)) !=3D NULL) {
> +		spin_unlock_irqrestore(&dev->rxq_pause.lock, flags);
>  		usbnet_skb_return(dev, skb);
> +		spin_lock_irqsave(&dev->rxq_pause.lock, flags);
>  		num++;
>  	}
> -
> +	spin_unlock_irqrestore(&dev->rxq_pause.lock, flags);

The retaking of the lock in the loop looks ugly / unnecessary to me

          struct sk_buff_head q;
          struct sk_buff *skb;
          unsigned long flags;
          int num =3D 0;

          __skb_queue_head_init(&q);

          local_bh_disable();
          spin_lock_irqsave(&dev->rxq_pause.lock, flags);
          clear_bit(EVENT_RX_PAUSED, &dev->flags);
          skb_queue_splice_init(&dev->rxq_pause, &q);
          spin_unlock_irqrestore(&dev->rxq_pause.lock, flags);

          while ((skb =3D __skb_dequeue(&q))) {
                  usbnet_skb_return(dev, skb);
                  num++;
          }
--=20
pw-bot: cr
