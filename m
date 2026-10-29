Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793242976;
	b=sS8aaVNlw8j2R1xWNZk6nPinY5lEHDS2Bf8PrvnWVH+9nI6jv8Enu1Up+/D8moMfUeuk
	 FHk9nrIgRC7K857FyZaM4Tf/zAdEH6h8h2OnM+yJB66rHafGGXInxwFyqpgs/QpN3L3Kv
	 Gt2G2i+CWX2Ay7e7/1ZZJYhzUpdUSOLORTYeNb2quCf4A0odsT0Pit5Z9MgTYOsEpM6Vr
	 j+y1CPw+ZBm9Km7bj43R0TCaB1PEFX68hkgyTrnHeqwezvWx3A+nZs4uVGeayOOsr/DzT
	 93pD1JwToLO0sPHVZv8DuGyMKQVYnMTMTEhAuf8vOCEnEQYPQzCNhROaD3O3mHTnGpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793242976;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=MJTAFr/nct8BR2PWhY9m1x54UXhrbFHiuq7wCiirHbA=;
	b=ElRYSQKcy8Pa+akV85D6AAfZOYNZB9uaXIGGtA8cHlEOkd5946Ma4UrdKE2YaSg/KKw2
	 Fn8vFCVnIk7e24kj0WVTSC5QQycZzOiBr+GuuTDnuH32eNEbIjwKXXar/3YM4jwYtbI+q
	 bPbyWENWHeyBflYCBbMoVNU8ywI7qzrIlLtbvmtzTyE7QjDZL+MMai1JoykDuMinw65Lv
	 CnUlm+CM46c/ktSPvwjhKgE9tVGIp4Uh5XS+jCjp3yN57SO0AM7mpGyGO+hfwEPeueZnW
	 6JYMVLANnVOX8dX7lWc1162ftF4hRCkvZjKG48EGXu1ezFbAuiKW2GsZTyXOpuy5DCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i20N95rk;
	arc=none smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AA1606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 03:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75AA1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i20N95rk
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7cc365db987so983394137.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 20:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793242975; x=1793847775; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MJTAFr/nct8BR2PWhY9m1x54UXhrbFHiuq7wCiirHbA=;
        b=i20N95rk6wxtdrQR+q3G5uzJPMIU4uWjvFTaKwCl1gislcnxgJsFidAdjdmOLPl110
         49XDz9Ofu4cv/FmlQuzhOaMZWTxecTZMCl72NhkqzWL9N/fDjJ0uph1JjPH67cGWNEoE
         ZKi+NDn23oEmvVHdLsKjaLAugggQI5mom5ZLq9mnMXgSws7QSRc8TnJdp2HmrDxHh//B
         yERDj32KXG5VzjcmEVH8sGlpQLdginhb/P+D8Nsfp0SkM0XvBOKiYQR9FHGmB/6nv9VZ
         KwEX9uW+MxZZmuXrxsVunrcLeXFXccx5uKysi8hwpBxS8lHE5KDALxN7JMkKO/2rZzLr
         EeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793242975; x=1793847775;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MJTAFr/nct8BR2PWhY9m1x54UXhrbFHiuq7wCiirHbA=;
        b=tzb9OQOmGuCu9d1qUs+SK++ex1u/3Fu4FwqhpBnKpaQ11VUMUfV7AYsD8DSAGAOx5d
         Mu3M3cQW4R/LECmR9UdEVDZjiTEEOukpfCyD/8d3Fm1jVf7tgDJQpXHi8MPwObwq5bNh
         2omkiK4aNY4DCkx10oc9rvg4qvuMCowlOj9c5uA3tDdfDNTBJZf+/VyUhl6pB52Kr3cD
         mqBMkwWVM9srrisg1ay62HoS+ZFQhi1UsTVMB+7vL9ZYA7YrCu8Qu7GiIeFLQ8jsjob6
         +zY3huuK8ZIxpOIdOfW3sok+vV3cGJhFFXeHezQXCmg3o3YyYT1IvRuCKEdsjAtVsINT
         VCrQ==
X-Forwarded-Encrypted: i=1; AKwUvBxwFQcnhnwT0Ond1GSTGnXXJOHyE0OdjCWEX0zsRG1eUzv797BeLYYXuozASJwYiSSuS5BkJXs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJU1fFj0U40mUwXw13Pla7vHgj0ZcxU9WnQHVrpLsbzA8xk5m/E
	+sqqCJOeYIdZzOecpKN59v06O5ljrZS7/gzLEKNehl9QxoqwP0SdM/U3
X-Gm-Gg: AYBFou3V+Vu1yYyT9eUW7kTU8ncFYifQm/XhmUyiKDtghJWy54AUiC+pvBkII+YjW8C
	hu2sp9J6OHGLrFF7aPWyRkmlVl8r3lLkxOmWKfkqTw14rB8/xptVe/uGwBBZvcMFReHwrjgNjF3
	V9fZJis5LSW2zXDAnFyZbsnXbB7zKgjerdN90NdZ/carlA4gsEso7CIMkr6fWPGbh1y3uLxB3qH
	vsidJSwk/EBo6zDWv9sCT/Ke3wmFz0frcbNqahv3JXzUeuo47RsGfw9C9HYaEJW0MZDcmcA0EuB
	aFLir6eATNSORKOMGUJSFR6AmFzu2m9y+Xa3/8i1ZCAKzbnWONrFqMzwE8N5376/mB6RehwlK0J
	XGc0x/s2G2rj5qWzHP7YYwrFuK9gLYIFhSmwNqt/NbNeNwc4Odovu8c0PoRfKLRSSOAD6UfUO1j
	mFtEagKcqNiFswIepY9xWnqCYKam+Yxn5VmKkH4an6DmbKvTt3B6QwL3fCFLDXcuE4KOOy6iEC8
	XMldhmG3004j5U4ZSqPZlCHDHPm2TMMxXiU2goEJhzidYCAzbx6uUNt0bMYdWsTiSJ+XuKIB/+o
	mPwPQPUashfGl3ZrS8FYljcVRLhzjlrWan1hpZ7sAGOi3Ap/9tX52BUGrzPHxHSg7OsQy0szGCB
	HE56wZtdJZQqYvkLAZFY/Kpw+RQPX
X-Received: by 2002:a05:6102:2906:b0:7cc:16e2:c1a8 with SMTP id ada2fe7eead31-7d03a4ba6femr2067670137.8.1793242975276;
        Wed, 28 Oct 2026 20:02:55 -0700 (PDT)
Received: from macbook-pro-de-joas.local ([2804:7f0:b101:c5e8:7d75:cb37:7054:6d4b])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec4f931911sm3939350e0c.10.2026.10.28.20.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 20:02:54 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, David S. Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 syzbot+88435e204734072bf39a@syzkaller.appspotmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH net] netdevsim: delete ports added after a failed reload
Date: Thu, 29 Oct 2026 00:02:45 -0300
Message-ID: <179324296598.34505.11070163314749859668@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

When a devlink reload fails, nsim_dev_reload_down() has already torn
the device down through nsim_dev_reload_destroy(), and
nsim_dev_reload_destroy() returns early on every later call because
devlink_is_reload_failed() is set.  new_port still works in that state
though: nsim_drv_port_add() does not look at the reload state and adds
the port to nsim_dev->port_list.  Nothing ever deletes it.  When the
device is removed, nsim_drv_remove() destroys the BPF offload device
and frees the devlink instance while the port's netdev is still
registered:

  WARNING: kernel/bpf/offload.c:794 at bpf_offload_dev_destroy+0x50/0x78
   nsim_bpf_dev_exit+0x7c/0xbc
  WARNING: net/devlink/core.c:557 at devlink_free+0x30c/0x3ec

and the leftover netdev then points to freed memory.  Bringing it up
afterwards:

  BUG: KASAN: slab-use-after-free in devlink_bus_name+0xa0/0xac
  Read of size 8 at addr fff000001a313118 by task ip/120
   devlink_bus_name+0xa0/0xac
   devlink_nl_port_handle_size+0x38/0x80
   if_nlmsg_size+0x340/0x7a8
   rtmsg_ifinfo_build_skb+0x74/0x218
   rtmsg_ifinfo+0xa0/0x18c
   __dev_notify_flags+0x1d8/0x2f4
   netif_change_flags+0xe0/0x150
   dev_change_flags+0x8c/0x1e4
   devinet_ioctl+0x9c0/0x1360

A successful reload after the failed one has the same problem:
nsim_dev_reload_destroy() skips the ports again and
nsim_dev_reload_create() then reinitializes port_list over them.

The ports are the only thing that can be created after the failed
reload, so delete them on the early-return path too.  The port_list is
valid there: the failed reload emptied it with nsim_dev_port_del_all()
and nsim_dev_reload_up() fails before nsim_dev_reload_create().

Fixes: 75ba029f3c07 ("netdevsim: implement proper devlink reload")
Reported-by: syzbot+88435e204734072bf39a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=88435e204734072bf39a
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Yaga Agent HackerSec Claude:claude-opus-5-5
---
Tested on net/main 94cea342e891 (arm64, QEMU, generic KASAN) with the
syzbot C reproducer (sets fail_reload, does a devlink reload, adds a
port with new_port, then del_device), followed by "ip link set <dev>
up" on any netdev left behind.  Without this patch both WARNINGs above
fire, the port's netdev survives del_device, and bringing it up gives
the KASAN report above (2 of 2 boots).  With it, 3 of 3 boots show no
WARNING or KASAN report and no netdev is left behind.
drivers/net/netdevsim/dev.o builds cleanly with W=1.  The
reload-after-failed-reload case was not tested separately.

 drivers/net/netdevsim/dev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index feb88cc..a871790 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -1697,8 +1697,13 @@ static void nsim_dev_reload_destroy(struct nsim_dev *nsim_dev)
 {
 	struct devlink *devlink = priv_to_devlink(nsim_dev);
 
-	if (devlink_is_reload_failed(devlink))
+	if (devlink_is_reload_failed(devlink)) {
+		/* The failed reload already tore everything down, but ports
+		 * can still be added through new_port after that.
+		 */
+		nsim_dev_port_del_all(nsim_dev);
 		return;
+	}
 	debugfs_remove(nsim_dev->take_snapshot);
 
 	if (nsim_dev_get_vfs(nsim_dev)) {
-- 
2.39.5
