Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F0936F8EF;
	Sat, 26 Sep 2026 02:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790390120; cv=none; b=ZwEE8Jzbz3aO1X03Y1zWDgeC0Vy+crd2DBCkqYJ2EAfsEaqST8+jemxdbxkGUHo+Dn5zq3NdbtRYo1WXuMDZdPzMR0W6HEX6LrJKED1zDjhssLiG/xw8LT5RU6dpEGED8WxZ8RwXnZAnYk4vmTaayRJ6OZ/bRzUpA6+louwua+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790390120; c=relaxed/simple;
	bh=HaBoEGCT9DT5h2iTrYck7tRQ+ElR7oB9n1ErRATdJPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fw2hE0MKgEP+A78Qe/YtSIvWd4FpEn6k2xSbxCrd+Cwnz9bzf60IhjHyEzJskZ5JBJTPO/wBfEuDXRc93M6HjNeuk+zdxea+5HOi3Ltvx1j3HKWhcQ68R+9zCxEvllGp3NbpCidYxwK937esAs2vvDY5yufttLdzJS0JYtGG5hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V50ipdsu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V50ipdsu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8892E1F000FF;
	Sat, 26 Sep 2026 02:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790390118;
	bh=Kl4af8S8fQ9Xp4YHhrKhPNrYHWjexFd7L9jHQSpwv5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V50ipdsuP8jvZhkg2ye5rkJ4btq1qH4B59cRJomuMgUxZ2H9OOn+Gtb+OZtxXr6Ki
	 B4N5UzxQp0dUlXix0s50rt3L9lk5hw9QOzMwbhCXMnRfHJrY8XXOqKmAYYqjrZsQzC
	 ATUW6LhorKuW9ov6YLl1YcvOLKuqPBf6yEtKfzfi517TBF5aTGOpz/OqKGQskW7qlU
	 xekID2DNUwkGVCjqCrvgFTCpmXRdcJ3vOh8/QjJKi2PREnhPP4FiF8GViCZayXsli1
	 9nM1Puv2l1HgwU2S6VaaaJccPpp+HBSRE1ccn+eFkIlRALLBc7ejQLnnsnSzNhdF5t
	 zJxpIMJRfDS2A==
From: Jakub Kicinski <kuba@kernel.org>
To: jie.wang@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	gregkh@linuxfoundation.org,
	3chas3@gmail.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	accessrunner-general@lists.sourceforge.net,
	syzbot+9b195c4f412ea5c4e56a@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] usb: atm: cxacru: fix NULL deref of atm_dev on sysfs writes
Date: Fri, 25 Sep 2026 19:35:17 -0700
Message-ID: <20260926023517.1568681-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922092953.4048507-1-jie.wang@intel.com>
References: <20260922092953.4048507-1-jie.wang@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
usb: atm: cxacru: fix NULL deref of atm_dev on sysfs writes

This commit changes the adsl_state and adsl_config sysfs store handlers
to log with usb_err()/usb_info() instead of atm_err()/atm_info(). A
write that arrives before usbatm_atm_init() has set atm_dev therefore no
longer dereferences a NULL atm_dev. It also rejects poll/start requests
with -ENODEV while atm_dev is NULL, before poll_state is advanced.

Closes: https://syzkaller.appspot.com/bug?extid=9b195c4f412ea5c4e56a

> diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
> index 636f7886fc260..501a51b27e466 100644
> --- a/drivers/usb/atm/cxacru.c
> +++ b/drivers/usb/atm/cxacru.c

[ ... ]

> @@ -396,6 +396,15 @@ static ssize_t adsl_state_store(struct device *dev,
>  		poll = -1;
>  	}
>  
> +	/* cxacru_poll_status() below dereferences atm_dev, which may not be
> +	 * set up yet; reject before poll_state is advanced so that
> +	 * cxacru_atm_start() can still start polling once it is.
> +	 */
> +	if (poll == CXPOLL_POLLING && !instance->usbatm->atm_dev) {
> +		ret = -ENODEV;
> +		poll = -1;
> +	}

[Severity: High]

Is this check enough to keep cxacru_poll_status() away from an invalid
atm_dev? The read is not locked, and nothing keeps atm_dev valid after
the check passes.

usbatm_atm_init() publishes atm_dev before atm_start() runs. If
atm_start() fails, it clears atm_dev and frees it:

drivers/usb/atm/usbatm.c:usbatm_atm_init() {
    ...
	instance->atm_dev = atm_dev;
    ...
	if (instance->driver->atm_start && ((ret = instance->driver->atm_start(instance, atm_dev)) < 0)) {
		atm_err(instance, "%s: atm_start failed: %d!\n", __func__, ret);
		goto fail;
	}
    ...
 fail:
	instance->atm_dev = NULL;
	atm_dev_deregister(atm_dev); /* usbatm_atm_dev_close will eventually be called */
	return ret;
}

The device controls whether cxacru_atm_start() fails on the MAC address
read. That failure returns before adsl_state_serialize is taken and
before poll_state is looked at:

drivers/usb/atm/cxacru.c:cxacru_atm_start() {
    ...
	ret = cxacru_cm(instance, CM_REQUEST_CARD_GET_MAC_ADDRESS, NULL, 0,
			atm_dev->esi, sizeof(atm_dev->esi));
	if (ret < 0) {
		atm_err(usbatm_instance, "cxacru_atm_start: CARD_GET_MAC_ADDRESS returned %d\n", ret);
		return ret;
	}
    ...
}

A "poll" write sends no CM request before this check. If one arrives
while CARD_GET_MAC_ADDRESS is in flight, it sees a non-NULL atm_dev,
moves poll_state from CXPOLL_STOPPED to CXPOLL_POLLING, and calls
cxacru_poll_status() directly. "start" and "restart" can do the same.

cxacru_poll_status() then goes one of two ways.

(a) It saves the still-valid pointer in a local:

	struct atm_dev *atm_dev = usbatm->atm_dev;

It then blocks on cm_serialize behind the MAC request in
cxacru_cm_get_array(). By the time it writes through
atm_dev_signal_change() or atm_dev->link_rate, atm_dev_deregister() has
freed the atm_dev.

(b) It loads NULL and dereferences it in atm_dev_signal_change(), or in
atm_warn()/atm_info(), which expand to usbatm->atm_dev->number.

cxacru_atm_start() never resets poll_state on that failure, and the
heavy-init thread exits with the interface still bound. So poll_work
keeps rescheduling itself:

	if (keep_polling)
		schedule_delayed_work(&instance->poll_work,
				round_jiffies_relative(POLL_INTERVAL*HZ));

After that, every poll error or line status change dereferences the
NULL atm_dev, with no further writes needed.

The v2 notes dropped an earlier atm_dev gate as "an unsynchronized
TOCTOU". Does this gate have the same problem? Would closing it need
real synchronization, for example gating on heavy init completion, or
serializing the atm_start() failure path with the sysfs writers?

> +
>  	if (poll == CXPOLL_POLLING) {
>  		mutex_lock(&instance->poll_state_serialize);
>  		switch (instance->poll_state) {

[Severity: Medium]

This is a pre-existing issue, not one introduced by this patch.
mac_address_show() uses the same unlocked check and then reads the
pointer again:

	if (instance == NULL || instance->usbatm->atm_dev == NULL)
		return -ENODEV;

	return sprintf(buf, "%pM\n", instance->usbatm->atm_dev->esi);

Suppose the usbatm_atm_init() failure path clears and frees atm_dev
after the reader loads the pointer but before vsprintf copies the six
bytes. Can this hand freed slab memory to userspace? The attribute has
no CAP_NET_ADMIN check.

A NULL atm_dev here only gives a small pointer, which vsprintf prints as
"(efault)". So the concern is the use-after-free read, not an oops. The
window has no sleeping point, so it is narrow.

[ ... ]

> @@ -481,7 +490,7 @@ static ssize_t adsl_config_store(struct device *dev,
>  			ret = cxacru_cm(instance, CM_REQUEST_CARD_DATA_SET,
>  				(u8 *) data, 4 + num * 8, NULL, 0);

[Severity: Medium]

This is also a pre-existing issue, not one introduced by this patch.
Since the dev_groups conversion in e605c30977bb, adsl_config_store() and
adsl_state_store() can send CM requests (CARD_DATA_SET,
CHIP_ADSL_LINE_STOP, CHIP_ADSL_LINE_START) through cxacru_cm() while the
heavy-init thread is still running cxacru_upload_firmware().

At that point the chip may still be in boot ROM or part way through the
FW_WRITE_MEM sequence. cxacru_upload_firmware() later clears halt on the
command endpoints, and a URB submitted from sysfs may still be queued
there:

drivers/usb/atm/cxacru.c:cxacru_upload_firmware() {
    ...
	usb_clear_halt(usb_dev, usb_sndbulkpipe(usb_dev, CXACRU_EP_CMD));
	usb_clear_halt(usb_dev, usb_rcvbulkpipe(usb_dev, CXACRU_EP_CMD));
    ...
}

Is a CARD_DATA_SET config accepted before the firmware boots silently
dropped once the new firmware starts? Should these writers also wait
for heavy init to finish?

>  			if (ret < 0) {
> -				atm_err(instance->usbatm,
> +				usb_err(instance->usbatm,
>  					"set card data returned %d\n", ret);
>  				return -EIO;
>  			}

[Severity: Medium]

This is another pre-existing issue, not one introduced by this patch,
but it relates to the adsl_config format. adsl_config_store() parses
both fields as hex:

	ret = sscanf(buf + pos, "%x=%x%n", &index, &value, &tmp);

cxacru.rst also documents the format as hexadecimal. The converter that
cxacru.rst recommends, cxacru-cf.py in
Documentation/networking/device_drivers/atm/, prints the value in
decimal:

	sys.stdout.write("{0:x}={1}".format(i, struct.unpack("<I", buf)[0]))

A value of 10 comes out as "0=10", and the driver reads that as 0x10.
Should the script use {1:x} for the value?

[ ... ]
-- 
pw-bot: cr
