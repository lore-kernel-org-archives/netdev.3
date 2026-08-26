Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7252036E9
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 02:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787709739; cv=none; b=HSAhqthqb+QgmvGR1kZs2tLub6stbOwzfi48742u/a0RnJZcjHE54TUjoKjQSYEMmaKcGOs8W37vl3Moy6lqLFiMMfiEem/ppw5mrqewYvfqp/N2mL4ZFAnAqwJ3fH47Yn/dnE34+UO/X1kbU0xVTv9s3PQY/wzCZvlVbPoKb7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787709739; c=relaxed/simple;
	bh=NJCCto9wLlVWCInGQDNhRaPAkrXW3Ymoo5rST/Wij80=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jwpGtfHYxDQNPEX4iKUeplFApB3m7WulWf1Xb+ykR0fNr76pw1s9PitfytQBUDiqTq3FPvbpkNvlpt1enTxpcXy2Or0h3oEQdEWRHRAlEi0+6J0h5Oog4kGmN2B1++wiYdUg03ZUujOTg2bhymg2yUXCKl3o94hqkRH/KXOz1zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fN1Xq/4g; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fN1Xq/4g"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-855c26cf490so4424377b3.0
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 19:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787709737; x=1788314537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/j2cKbyDnLqH/Uv8OCdqOUyQE63/GyK6ijE5X1RB5ZA=;
        b=fN1Xq/4glB5q+SsFCeTwUbnBh8SV+IW7YEbqYlWcu57h/N80AHskRkSIWIPhQhCGA/
         QPb8OwVMPVwL8gvlKKE6QkFn58bjm9sylkWXuO/dmtrFI3cIA/Mphvck32BhGH/2wmXk
         tIGOSbqaPRh7whFWXMI3Ml+JzFEBQ7497bKB+ZMPaT6fX/6zlBynC+BB5fCV9LdVES1M
         d4+yANHhMzuNlSp96tdBXrsLhB8TyUeKhQmdWTGVYvunkzfWiQV00ontRkgQT4xnA5qr
         vHa0SVTFln7+7VzUn8I350DUm2+t0EL4+2mugRcQencWIvIwwVAzwvFVihopug1DXWKX
         XTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787709737; x=1788314537;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/j2cKbyDnLqH/Uv8OCdqOUyQE63/GyK6ijE5X1RB5ZA=;
        b=gSUxDUgsUqH9XkSGI9Sg0u8sMSYzK8x2rpNKyddTHggzuA46+wMn0PB0mKts38iPjO
         tgr5/XPFPuJN6ZWRFE6dJbLuxC0TuqSQRMHVAuVSA/EpEkwtQdujWYMnWOzk0ls0K03B
         zUGMD6U5LKk8CGKUnwys6InkL8quIR3reoXUGGDxNThlGhIwTheTUP5xwDTBGOECo+Wk
         +gPN8hnyP+v3LkzTugRueCC/Kfb6U6dFL9Fwfz10PlmZhY06XFEGmaY2H9aSCZohxivm
         fM34pGGTXzqtg1JmPrA2sDMrYMeUX1Lubw6bDPNIgCrhcTMELAaAb1vpGQn5VrF1aJme
         HU6g==
X-Forwarded-Encrypted: i=1; AHgh+Ros2fGhyK9Sv8SnQ+PDt0W29KGMW3HZ8QGfmk/hopB9cS2Kuo0ly6N0bwIMowuIBmd22AtnlWE=@vger.kernel.org
X-Gm-Message-State: AFuF++mIEDamc6tIHAIGyrM11bglCQoNYMkDwc4PlUbIOUdZZua+/T4n
	OhOfC0sAbA/srBbmFacGFIlx8jD0HaGaIC37kZyfOId0DnFPD/M9p8L6
X-Gm-Gg: AR+sD13j8JMEuYIMQNPFQqUIdsiDGEkr50ziyNd8y6vVat5e424Rj0gVWPjg85oyZKp
	ho3yEtM4KvbleLXSAhLkRVbRARu7Ww7xWLSWU1IAVPeJA+StHCqkSS0vudtgyahP9UUXkZDE1xz
	E8vGshYJ2puUVzXAId+Mts4ttzduissjwAfDidyTCA9qqa9JIPpasdlh0N4fu2RUXjeA8Hv6Ch0
	pVWnUEc+I/pAWbPhf8q854I2TFyqQeJxoVyt0Tn4sA+Cy1CTjveZ5f2dyAI2gHBnPm+QRI7SI8Y
	UkPfI8XWiyJ1d/EnbpFan+WiL1DJHMEIIgILmrV+LvR8/ozG4lC6I63Po2RlsXgSJN8Bm2kWlB9
	izNkp1ZwkMThymsDOfK58pfO1M0POhkJP7frIU5yZvvsEzjkV8AUivg6BSVdNFh6etN6f0H85X4
	rHSLnxPs2Q2H+jEaJjb2OXUCsSs5bUjygMvQz5MMJ66YLGDb3WP1kvezNDIhOLgRkA+cxFwvSQ+
	7Ohbk1vxRUC615eO6AVybO+kl3IY6w0oV+4vmo5Ng==
X-Received: by 2002:a05:690c:6a10:b0:81e:c972:e8c3 with SMTP id 00721157ae682-8574087e819mr16641587b3.29.1787709736910;
        Tue, 25 Aug 2026 19:02:16 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85705f35aebsm9805617b3.15.2026.08.25.19.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 19:02:16 -0700 (PDT)
Date: Tue, 25 Aug 2026 22:02:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Qihang <q.h.hack.winter@gmail.com>, 
 jv@jvosburgh.net, 
 jiri@resnulli.us
Cc: andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com, 
 netdev@vger.kernel.org, 
 Qihang Tang <q.h.hack.winter@gmail.com>, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2ec10017f4836@gmail.com>
In-Reply-To: <20260824021802.90369-1-q.h.hack.winter@gmail.com>
References: <20260824021802.90369-1-q.h.hack.winter@gmail.com>
Subject: Re: [PATCH net 1/2] bonding: reject frames with insufficient headroom
 in bond_header_create
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Qihang wrote:
> From: Qihang Tang <q.h.hack.winter@gmail.com>

Thanks for working on this Qihang.

Minor: a patch series should generally have a cover letter

> AF_PACKET SOCK_DGRAM sends reserve skb headroom from a snapshot of
> bond_dev->hard_header_len.  A concurrent bond type change can switch the
> active slave to one with a larger hard_header_len between that snapshot
> and bond_header_create(), so the slave's create() pushes or writes past
> skb->head.

Are we certain that bond and team are the only devices that implement
header_ops->create?
 
> The hard_header_len snapshot series that fixed the SOCK_RAW send paths
> deferred this SOCK_DGRAM race: dev->header_ops is the stable
> bond_header_ops, so snapshotting header_ops in the caller does not help.
> 
> Reject the frame if skb headroom is smaller than the active slave's
> hard_header_len, before delegating under the existing rcu_read_lock.
> 
> Fixes: 950803f72547 ("bonding: fix type confusion in bond_setup_by_slave()")

What's the rationale behind blaming this SHA1?

> Cc: stable@vger.kernel.org
> Cc: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Qihang Tang <q.h.hack.winter@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 522eab060f9e..9ec663610dfd 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1524,10 +1524,24 @@ static int bond_header_create(struct sk_buff *skb, struct net_device *bond_dev,
>  	slave = rcu_dereference(bond->curr_active_slave);
>  	if (slave) {
>  		slave_ops = READ_ONCE(slave->dev->header_ops);
> -		if (slave_ops && slave_ops->create)
> +		if (slave_ops && slave_ops->create) {
> +			unsigned int hlen = READ_ONCE(slave->dev->hard_header_len);
> +
> +			/* Headroom was reserved from a snapshot of
> +			 * bond_dev->hard_header_len that may predate this
> +			 * slave (concurrent bond type change); reject if
> +			 * insufficient for the slave's create(), which
> +			 * pushes its own hlen.
> +			 */
> +			if (skb_headroom(skb) < hlen) {
> +				ret = -EINVAL;
> +				goto unlock;
> +			}
>  			ret = slave_ops->create(skb, slave->dev,
>  						type, daddr, saddr, len);
> +		}

Ideally we could fix this in dev_hard_header or PF_PACKET itself,
rather than in each implementation that's in scope.

But there seems no way around holding this rcu reference on the slave
device while re-checking.



>  	}
> +unlock:
>  	rcu_read_unlock();
>  	return ret;
>  }
> -- 
> 2.50.1 (Apple Git-155)
> 


