Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792883227;
	b=HBM1wH35VnW2EJGyl10A7OBc4ctdey1PKUZ2uYtIG7CvVpWBHdL60U1nYOmCSQo7jboM
	 ENzTPfK64NmX2oH09t/h5ThYsfOzns6i00v6m1enxm8AMDObFOL2IsKlCxGtR8FcOUOAw
	 qsHbnZuRmhRMXG+0UL/D5TMEl65mjzpiZfXGbdQhNMJ2rSBOYadF4vXDSoF6fNgLrxeJ2
	 LgSjllX7TOf2HdGzGVoQ2tqfyh2qGM8KosuJ3aQ9LuCm7/WfPFioKQTZRUluwoR+j60sK
	 DEK9sVyqno9uOb0QeU7vc77iDup2qA7mzlWUN4kAwopCg1Ru0aKBjzHKkje9KIKwixA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792883227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=ilKVSD9FJbr4rCgUq3aZ7XRBwC0roP+y+YvlkpAT2Pw=;
	b=gtO7/nBInZUlmUxslCblEQ/kizPjjRgdUBQRsyFe+6rICl15+dptiyM+aGgd4zB1bapW
	 IvEaLXYblzyEk64eQRyzf2cKIvYK984Xi2BJhc4FaQPTZkEnWj7Ixj798KTRwXQvIj4jU
	 aWTN6vnqGXdSlpjsNlXVmkMDrUngxvGn0AaG0IWhTyTAlQlg2muIEUVmJfqBfh4wgrJsi
	 wvWdqP9Iyu5iPwAOtJ42DdVfFzX2EC6VLtBj8xL8yEhfrl1jN8/+zXNOuZFF50D44/5Ef
	 /P2tqNvLdKjZHgxcuSgSzKLnxWVTRlpI/MIB8YDHzie94OPCwL7IzYyMco5hia+Rq1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N9WzVPxB;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79C0606A31D
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 23:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A79C0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N9WzVPxB
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c45551fa84eso286698166b.3
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 16:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792883225; x=1793488025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ilKVSD9FJbr4rCgUq3aZ7XRBwC0roP+y+YvlkpAT2Pw=;
        b=N9WzVPxBXctumTp0wOXBruzh3pYlSuW0il9yspz22fQ8bBM7aLv/Kv50Oss6qBHO4c
         pXD6s9Y6qS362JkZKTQTIc0Of6sF0AW5/JQPYcTs3L4YjuRLmKvUZT2st1Urfw+IhpFl
         giRZPBIIJMHe8RLvryIZjSijssm5f4jV3B7PWhus2f4d5g6MEoMBE1IGkv5BmUE+xktJ
         agPprLd4htxF+mcGgIO16dagm3kR/8FXNaQS7Oc0bCCvqUjrS42z8Kr31LCWF54NES+U
         SaDVP5udDmBlbZ7ofE9sy3gIZ2rlRfN1Ao/t4+BTC5CtreVqbPD0kNCIzbUNaDvRKV2g
         9nhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792883225; x=1793488025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ilKVSD9FJbr4rCgUq3aZ7XRBwC0roP+y+YvlkpAT2Pw=;
        b=RZjaoE2TuCEwpL9GB8tbDH0NcpTgc3TR3TaSkA//P8oXAkI/TZp4THmygPOIvSrXQM
         NHG14ZESDIwb5W95Q1Tm+xLDsNXKuErlekggj0drVmk+fydcxClTDb0C4KONI9sK/hVg
         JMsMMDX4WDp6mAPR1BBBVRVIJcuT/sLbCyeerKOuTT2qkhwGe5zVZ4mbFQJu+fTwNspK
         35/i/5IkPlRDkHYqLPmmMHj6GsnWB/MJBpkYs4zdIFFDxyqp+g6IK2zxg9OB28gSJtBI
         n2gIZaAtw/kM4Mg4Pt5gUqCJR4NrgulCVXsPcx0GUgbCqVkZ/leNopeNovzugK3Cji1f
         k+Jw==
X-Forwarded-Encrypted: i=1; AKwUvBwrgOeRjxNzQxYF1TB70zUs7zm+a04IqTPEqtNKLSVFeY+UWgGPwIc0gPGRxDQYhwetSRfmYSs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJxR3a7q5rXHljIY2yPjnolYu6J4NmXXzk5pmbDpZjz/lZpv/e
	brmK8/Ol7KWwLwNHgbUphylDEBwUL+EcOhhffm80MfRARPkqG5h+GDyB
X-Gm-Gg: AYBFou0jbNM4jcYldcqogZ4ubQ+XbpY3KFNb7BWeKO/lJcy+tQI8KMyeBpLHpDH+Cmq
	7f0jHv0JRb1PzsS9GDtPWVfMjV2Dnr7PjgWQ+QnoTqkgBwLLZFbhxvKfigtFvc2fyxGMScOu9mI
	wYBIiH8LVbbqHCUN4b4nQSiH/zRer23AXWx4PV7CsgG7k2HQaiua/MNzlVCBdvTvk7TAH/AJukD
	AJgcDu7OJBhRR+TUWUshvAo4lK7AqycizvPKEkO2hhVTaT11Ycze92SYKrjcS4KZninvTR9ZC3o
	lfwoNq3ZnuPMhkiVmG/RRZrYpYVKE13jDvsANiXonLu5Md2XHp+b/BRJ6u6dFMR/fBA+kWcJSVQ
	AcqT05DK7hnMpmbXO6Mp9FVezMOsYQqPGhtSCJuvL//QXy7Rnb4quscdA42B2Gpshe4xEuEhIst
	wdgKpKe3hT41TGwIl5G6orK52wjgt5L8Lqi98sNPjvM7kU0a9UllCdVXYwhaaRsz3P2lTJe450F
	kFlSq86j2sdQsSKA8ig+tQsG0ILSF7VYEWPk/27/RPSNzxdJlBQJLm9
X-Received: by 2002:a17:907:2d21:b0:c3f:dce3:20d5 with SMTP id a640c23a62f3a-c46bdc10b94mr344242866b.22.1792883224932;
        Sat, 24 Oct 2026 16:07:04 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:49::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd66fa1asm136868366b.62.2026.10.24.16.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 16:07:04 -0700 (PDT)
From: Sam Crossley <samuelcrossley@gmail.com>
Date: Sat, 24 Oct 2026 16:06:04 -0700
Subject: [PATCH RFC 2/2] netconsole: add configfs trigger to replay printk
 buffer
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-netcons-replay-upstream-v1-2-9613f38496e5@gmail.com>
References: <20261024-netcons-replay-upstream-v1-0-9613f38496e5@gmail.com>
In-Reply-To: <20261024-netcons-replay-upstream-v1-0-9613f38496e5@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Paolo Abeni <pabeni@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Sam Crossley <samuelcrossley@gmail.com>
X-Mailer: b4 0.16-dev

Netconsole only forwards records while an enabled target and its transport
are available, so enabling a target after startup, or recovering from an
outage, leaves a gap in the remote log.

Add a write-only replay attribute at /sys/kernel/config/netconsole.
Writing 1 rewinds the basic and extended netconsole consoles to the oldest
retained record and queues the records for transmission. Other registered
consoles are unaffected. Records keep their original printk timestamp and,
in extended format, their sequence number, so a receiver can deduplicate
what it already had.

Replay is best effort and asynchronous.

Note that "replay" is now an attribute in the netconsole configfs
directory, so it can no longer be used as a target name.

Signed-off-by: Sam Crossley <samuelcrossley@gmail.com>
---
 Documentation/networking/netconsole.rst | 14 +++++++++++++-
 drivers/net/netconsole.c                | 25 +++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index 4ab5d7b05cf10..2e489dd64ba42 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -111,7 +111,8 @@ netconsole module (or kernel, if netconsole is built-in).
 Some examples follow (where configfs is mounted at the /sys/kernel/config
 mountpoint).
 
-To add a remote logging target (target names can be arbitrary)::
+To add a remote logging target (target names can be arbitrary, except
+"replay", which is used by the attribute below)::
 
  cd /sys/kernel/config/netconsole/
  mkdir target1
@@ -125,6 +126,17 @@ To remove a target::
 
  rmdir /sys/kernel/config/netconsole/othertarget/
 
+To replay the records retained in the kernel printk ring buffer to the enabled
+netconsole targets::
+
+ echo 1 > /sys/kernel/config/netconsole/replay
+
+As during normal operation, records above the current console loglevel are not
+sent.  The replay is best effort and asynchronous: the write returns once the
+consoles have been rewound, before the records have been transmitted, and a
+console whose lock cannot be acquired is skipped.  Only netconsole output is
+replayed; other registered consoles are unaffected.
+
 The interface exposes these parameters of a netconsole target to userspace:
 
 	=============== =================================       ============
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index b358e5c367351..f527a5ee45662 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1830,8 +1830,33 @@ static const struct configfs_group_operations netconsole_subsys_group_ops = {
 	.drop_item	= drop_netconsole_target,
 };
 
+static ssize_t replay_store(struct config_item *item, const char *buf,
+			    size_t count)
+{
+	bool replay;
+	int ret;
+
+	ret = kstrtobool(buf, &replay);
+	if (ret)
+		return ret;
+	if (!replay)
+		return -EINVAL;
+
+	console_try_replay(&netconsole);
+	console_try_replay(&netconsole_ext);
+
+	return count;
+}
+CONFIGFS_ATTR_WO(, replay);
+
+static struct configfs_attribute *netconsole_subsys_attrs[] = {
+	&attr_replay,
+	NULL,
+};
+
 static const struct config_item_type netconsole_subsys_type = {
 	.ct_group_ops	= &netconsole_subsys_group_ops,
+	.ct_attrs	= netconsole_subsys_attrs,
 	.ct_owner	= THIS_MODULE,
 };
 

-- 
2.53.0-Meta

