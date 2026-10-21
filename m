Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792543932;
	b=f0DzNXzuHVF4IJQ+m3pj6XaR6HVayW7/gUNY8m2hgWahzgTfziSrZuRLy9stJnQsHWmq
	 04sfK8Iv2KWxwfHIWgeAO2651BDR7NObn43QbzwPxFTU74IX0wXOp+e/Lz3xNFL9j1/wI
	 kXgxA/10yBJlIBO/z1y0PUEuzd9a5vot+YGO+NSFQmG2PpoGZB40r1Lt83lCMJ5yKeBMM
	 MCVVaXYSTKUg6jWuQ3C0PHsJIRvhFHSxjX02wHJ7kHB/dmBJ6e1A7C7J1Ipf5iEi6XLFq
	 dHMJi8s5h5jX3uJbdNsZL52D5/oe9sHVfcKF1lkw/NgM8xjDwtXhZttFAk2fN7ibFrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792543932;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=prmScGbjI7+4MtWkSwMe0QqbWgh0FbO2nXsCboobksk=;
	b=Ll8eTY/hG+IkEFuumHPBKDmrMp7dJmquO8kYhNXJ5b7lTsfr8nbRk0FTneFbhQcnaixH
	 kerkwkh65yRATgcwbHeb59T72NPEuZySH8V9ygN8Lx4dN6TpZwmsxB/rzoYR4cbqlArL9
	 Oky1tB70A+bV7UUwqJ0Xj9vuNEfA4/b/dU0CtS4s46Nh6NVskwQztFhU/mT4Rcby1UpRm
	 DaaIyt3qCnVJfX+6nT0ZQXo64m0/FlRhCCxzWH98YOzHOvJPekfL9BQ4Y7od7PH8UJ1o4
	 4tqSaJxoVQ8wvBNe3TD06yEuJfNyITZAEp+BwTnKMD4BKOsYCfr28LohUnRPMRcaQZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BA2AV4xO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C140606A31A;
	Wed, 21 Oct 2026 00:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BA2AV4xO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B49F1F000C9;
	Wed, 21 Oct 2026 00:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792543931;
	bh=prmScGbjI7+4MtWkSwMe0QqbWgh0FbO2nXsCboobksk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BA2AV4xOal6/+GxU4jjEoRySKaCCZQsXun20R2QCHlALBj7zOCiJuv5rnyltXvTrZ
	 qNFmzKlb3y0Vca/2tdIqQNsAwi4DGnxb9I39nZWcxxz5UtX6RJF8s/lHDAgDEKWZ15
	 qb5RBx7emeXuS5OlEwD5Nfk20jn9G+G8hrwuzk8G86xx04FFzaI8aKv53XvYH83RpP
	 wKFOfPKlKqJVIxrHYQzyJ1Q80YEePvBlbjEZP9yM8bpp0+BWJFFDELfdMlLsYusytC
	 GryvkE6l4bZu1QzxhmuH1JHi5qfel6Uu/s+IhJajVjj9BtBQTBJLaVPlUjF/88tBEM
	 VmSXAmf7yFKpA==
From: Jakub Kicinski <kuba@kernel.org>
To: hsu.chih.kai@realtek.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	nic_swsd@realtek.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	edumazet@google.com,
	bjorn@mork.no,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	mail@birger-koblitz.de
Subject: Re: [PATCH net-next v7 01/10] r8152: split r8156_init by generation and factor out wait_autoload_done
Date: Tue, 20 Oct 2026 17:52:10 -0700
Message-ID: <20261021005210.1254886-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014081904.6491-2-nic_swsd@realtek.com>
References: <20261014081904.6491-2-nic_swsd@realtek.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
r8152: split r8156_init by generation and factor out wait_autoload_done

The patch splits r8156_init() into two functions. r8156_init() now covers
RTL8156/RTL8156B, and the new r8157_init() covers RTL8157/RTL8159. It also
moves the repeated PLA_BOOT_CTRL AUTOLOAD_DONE polling loop into a new
wait_autoload_done() helper built on read_poll_timeout(), and converts the
r8153 init and ups_en paths to use it.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index af3d7dcb2f141..518a2b42c2200 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -4172,6 +4172,23 @@ static u16 r8153_phy_status(struct r8152 *tp, u16 desired)
>  	return data;
>  }
>  
> +static int wait_autoload_done(struct r8152 *tp)
> +{
> +	u16 ocp_data;
> +	int ret;
> +
> +	ret = read_poll_timeout(ocp_read_word, ocp_data,
> +				test_bit(RTL8152_INACCESSIBLE, &tp->flags) ||
> +				(ocp_data & AUTOLOAD_DONE),
> +				20000, 10 * USEC_PER_SEC, false, tp,
> +				MCU_TYPE_PLA, PLA_BOOT_CTRL);
> +
> +	if (ret)
> +		dev_err(&tp->intf->dev, "autoload done timeout\n");
> +
> +	return test_bit(RTL8152_INACCESSIBLE, &tp->flags) ? -ENODEV : 0;
> +}
> +

[Severity: Medium]
Can this end up reading uninitialized stack memory in ocp_read_word()?

read_poll_timeout() runs op before it evaluates cond, on the first
iteration, after every sleep, and once more after the timeout expires.
So once RTL8152_INACCESSIBLE gets set, the helper still issues another
ocp_read_word() on PLA_BOOT_CTRL before the test_bit() in the condition
gets a chance to stop the loop.

In that case generic_ocp_read() returns -ENODEV without writing to the
local tmp. ocp_read_word() ignores that return value and still does
__le32_to_cpu(tmp), then hands the result back as ocp_data.

The loops being replaced did not do this. r8153b_ups_en() and
r8153c_ups_en() tested the flag before each read. The init functions
tested it right after msleep(20) and left the loop before the next
read.

The test_bit() short-circuit means the garbage is never acted on, but
the read itself is still undefined behaviour of the sort KMSAN is meant
to catch, and it now happens whenever the device goes away while we are
waiting for AUTOLOAD_DONE.

A flag check before the poll would only cover the entry case, since
the flag can be set during the sleep. Would it be better to initialize
tmp in ocp_read_word() and the other ocp_read_*() helpers, given that
plenty of existing callers already read without checking the flag?
Or is an open-coded loop that tests the flag first preferable here?

[ ... ]

> @@ -7225,22 +7226,14 @@ static void r8152b_init(struct r8152 *tp)
>  static void r8153_init(struct r8152 *tp)
>  {
>  	u32 ocp_data;
> -	int i;
>  
>  	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>  		return;
>  
>  	r8153_u1u2en(tp, false);
>  
> -	for (i = 0; i < 500; i++) {
> -		if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
> -		    AUTOLOAD_DONE)
> -			break;
> -
> -		msleep(20);
> -		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> -			break;
> -	}
> +	if (wait_autoload_done(tp))
> +		return;
>  
>  	r8153_phy_status(tp, 0);
>  
> @@ -7341,22 +7334,13 @@ static void r8153_init(struct r8152 *tp)
>  
>  static void r8153b_init(struct r8152 *tp)
>  {
> -	int i;
> -
>  	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>  		return;
>  
>  	r8153b_u1u2en(tp, false);
>  
> -	for (i = 0; i < 500; i++) {
> -		if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
> -		    AUTOLOAD_DONE)
> -			break;
> -
> -		msleep(20);
> -		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> -			break;
> -	}
> +	if (wait_autoload_done(tp))
> +		return;
>  
>  	r8153_phy_status(tp, 0);
>  

[Severity: Medium]
Is the commit message accurate for r8153_init() and r8153b_init()? It
says:

  a plain AUTOLOAD_DONE timeout is logged but otherwise treated as
  success, same as every one of the loops it replaces, which only bailed
  out early on RTL8152_INACCESSIBLE and otherwise fell through to the
  rest of the init sequence.

and:

  No functional change intended.

In these two functions the old loops did a break, not a return, when
RTL8152_INACCESSIBLE was set:

		msleep(20);
		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
			break;

So init always ran to the end of the function. Only r8153c_init(), the
old r8156_init() and the two *_ups_en() loops returned early.

wait_autoload_done() returns -ENODEV whenever RTL8152_INACCESSIBLE is
set, so both functions now return early instead.

The commit message says the early return costs nothing because
generic_ocp_read()/generic_ocp_write() short-circuit. However, the
skipped tail also does work that does not go through OCP accesses:

  r8153_init():
	usb_enable_lpm(tp->udev);
	...
	tp->coalesce = COALESCE_SUPER;   (or COALESCE_HIGH / COALESCE_SLOW)

  r8153b_init():
	usb_enable_lpm(tp->udev);
	...
	set_bit(GREEN_ETHERNET, &tp->flags);
	...
	tp->coalesce = 15000;

usb_enable_lpm() is a counted USB core call. It decrements
udev->lpm_disable_count and does not check the driver's
RTL8152_INACCESSIBLE flag.

The polling interval also changes. The old loops used msleep(20), while
read_poll_timeout() with a sleep_us of 20000 ends up in
usleep_range(5001, 20000).

These differences only show up on error paths. Still, could the commit
message describe the new early return in r8153_init() and r8153b_init()?
Or should these two functions keep the old break-and-continue behaviour?
-- 
pw-bot: cr
