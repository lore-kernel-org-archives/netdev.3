Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D823ACA59;
	Thu, 16 Apr 2026 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776344363; cv=none; b=jFECfByzbsDrbWeTg/eRQph7K1Ns+IcPg4yJaQ2Kea+Hu1Kmo/FjPSWoR4VZqu/naZdlgAH/TeS1RuDVrvKpJxtv1iESl2Gk/Q5fBQSGekMWL+I5/8KdoWs3TMN+sODzKKdEiH1OjYhVs0Us2zd21RZ70Layah27iXk7BX4bpSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776344363; c=relaxed/simple;
	bh=Orq+NAg87nw8SEvVkb7dJI/WZo6ZjMunXXfeUX9qWzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHpNlc25QEMYdGokxJroHiMHlfg4t5plLiqV1ADrJEfVwTLa7EN0OuwBWLJq6PgLkW83mWtLiqS8X3zZg5de/05eY9wEuRo/ZDOKR4AnOsUSYFv+7qZlNq/2H5bOQBKBUlpXh2I+FPi1AuGutW1awh+JbqnIIGHPOLS8vzeuhoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvNQX1fL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvNQX1fL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1364C2BCB3;
	Thu, 16 Apr 2026 12:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776344363;
	bh=Orq+NAg87nw8SEvVkb7dJI/WZo6ZjMunXXfeUX9qWzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lvNQX1fLTOPAwMmPaM6WbhpH0uXyaXyc8udKX+OsCxdJBSAhPbhjW89OFxouN3qfN
	 aiFy7BK9Zjx4pajjqadRR9JEXtSaJG9TVJo7Ss9yV/i+5NeIVt/ZP+WN4civiiHdof
	 L0IQcNk27XzgQXef1uGHrVcoyVenAKmxPBUSReyGSuPSerK/yA2iSBcAfqq3/pyWzN
	 OMVxP+CkQJIPaZlRN09JTDZoHxC4mGPXv6jG1FGE+zHR0nxwzmEgSMP7pSQEPHvJyV
	 bLTlbTHBCWmWR87S7ibk/IuFc6kj68gTSWXSWq361Daeodx0IBX41/KeD2tNpaqMVJ
	 Ok+Wd1oCXD9dQ==
From: Simon Horman <horms@kernel.org>
To: shuvampandey1@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mISDN: socket: drop device references acquired by get_mdevice()
Date: Thu, 16 Apr 2026 13:50:30 +0100
Message-ID: <20260416125029.851168-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414071322.30851-1-shuvampandey1@gmail.com>
References: <20260414071322.30851-1-shuvampandey1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
mISDN: socket: drop device references acquired by get_mdevice()

This patch attempts to fix a memory leak where device references acquired
by get_mdevice() are not dropped. It adds put_device() calls in the ioctl
completion paths and in the socket release paths.

> diff --git a/drivers/isdn/mISDN/socket.c b/drivers/isdn/mISDN/socket.c
> index 77b900db1cac2..9209ee68f9cda 100644
> --- a/drivers/isdn/mISDN/socket.c
> +++ b/drivers/isdn/mISDN/socket.c
> @@ -266,6 +266,11 @@ data_sock_release(struct socket *sock)
>  
>  	lock_sock(sk);
>  
> +	if (_pms(sk)->dev) {
> +		put_device(&_pms(sk)->dev->dev);
> +		_pms(sk)->dev = NULL;
> +	}
> +

Could this introduce a use-after-free regression if the underlying hardware
is removed before the socket is closed?

It appears the mISDN subsystem handles kobject lifetimes unconventionally.
Hardware drivers manually call kfree() on their private structures immediately
after calling mISDN_unregister_device(), without waiting for the kref to
reach zero.

If a socket holds a reference to a device when the module is unloaded, the
device memory is synchronously freed. When the socket is later closed, this
put_device() would attempt to decrement a kref inside an already freed driver
structure.

This isn't a regression, but is there a use-after-free in the stack teardown
when the hardware is removed?

When a socket is bound via data_sock_bind(), connect_layer1() stores a pointer
to the device's stack on the channel (ch->st = dev->D.st). If the hardware is
removed, mISDN_unregister_device() calls delete_stack(), which unconditionally
frees the stack pointer.

When the user eventually closes the socket, data_sock_release() executes:

    if (sk->sk_state == MISDN_BOUND)
        delete_channel(&_pms(sk)->ch);

And delete_channel() dereferences the dangling stack pointer:

    write_lock_bh(&ch->st->l1sock.lock);

This also isn't a regression, but can data_sock_release() allow an
unprivileged user to spam the kernel log?

If an unprivileged user creates a SOCK_DGRAM socket with protocol
ISDN_P_LAPD_TE and closes it without binding, data_sock_release() evaluates
the closure:

    case ISDN_P_LAPD_TE:
        delete_channel(&_pms(sk)->ch);

Since it was never bound, the channel's stack pointer remains NULL.
delete_channel() handles this by executing:

    if (!ch->st) {
        printk(KERN_WARNING "%s: no stack\n", __func__);
        return;
    }

Since there is no ratelimiting on this printk, could a user continuously create
and close these sockets to flood dmesg?

>  	sock_orphan(sk);
>  	skb_queue_purge(&sk->sk_receive_queue);
>  
> @@ -387,6 +392,7 @@ data_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
>  			strscpy(di.name, dev_name(&dev->dev), sizeof(di.name));

This isn't a regression, but might this read from freed memory if a device
rename happens concurrently?

In IMGETDEVINFO, the device name is read via dev_name() without holding locks.
Concurrently, a privileged user can issue the IMSETDEVNAME ioctl, which
executes device_rename().

Since device_rename() updates the device's kobject name, allocating a new
string and calling kfree() on the old name string, it seems strscpy() could
read from the freed name string if executed at the same time.

>  			if (copy_to_user((void __user *)arg, &di, sizeof(di)))
>  				err = -EFAULT;
> +			put_device(&dev->dev);
>  		} else
>  			err = -ENODEV;
>  		break;

[ ... ]
