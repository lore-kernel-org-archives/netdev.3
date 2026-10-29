Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278192;
	b=w3F07uPAFQOrdiZI6aQUtU9o2jiuVf0rwtHUWUIe8O5tSFQANF9HNOxJrhXhsT3UGODq
	 XUsBi4Vn0LhvjlZodus6kGjAlkwpHEJaW9nem33sQjDNH934fckD3sNIjE+Gx5LhnhPUX
	 bud+wSKTdwuTlOQAFcLVdoIlskcIeVhPIQYMG5pNQo7vs1CE0tfUzJH5jFXuOosBx2i95
	 8iCFeaW3EOLFqQu79mY7dfoCN55C2JoI9HEb/JyG5uaD0/00F/Hdhd1ieEKo7oW+tOeJ5
	 +0/GpmBUjEFk+6q9lMhp0dQt1qm0f59V7BP19dIU1eGp+sdX9pqmCDOh+a1dcI5lm+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278192;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ROp3jZYajDVDh8nm32pw5xyIgzSFtN3IpqGpjVrWuQc=;
	b=v+ci4mV3etlqLBZvwFF4P+istSMV5xp81+FjEGHmZzodBk1sVdiDQgsHyDgh961Y1eqO
	 WchoKMqw/rkeFj5yUN2RQ1xp79etSAJOnolQXx8ymQccK8VeI0VhT3QqzVlVX4IsEsf46
	 yXnxJX96xQaQPv2GjOB6rvnWS15E8fWp3MqtJWjOpFDTOAUfzmj6L9cnQsBi7UPfDoy+g
	 VBFWdafGpJfcRWvPEsV71e9wson0kEqzWO1tpR+OaADeiPIazP4QPrMUA5uQ8cR+ZC6qF
	 IziyT4J7cjI9Papsl/80YiNpf/wm8nW9nP1Cd9ZfvylgCvmERoe8n/LKNSv19xGjwnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SyStkEZm;
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBF4606A32D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 12:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BBF4606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SyStkEZm
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7c322cbc998so442307137.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 05:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793278191; x=1793882991; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ROp3jZYajDVDh8nm32pw5xyIgzSFtN3IpqGpjVrWuQc=;
        b=SyStkEZmAKI1EJX06M5T1xEgkXiYvK0jB/EsIJc74PsoZLVPeLOliWrXZGuSkUX2uJ
         09xrz2uFk5twc2iZjQWB9gE38cAAwiBu4eFYUA1OUtXnTpLY7gWfu/867+BZELjIY1oy
         p9k+7TcpJu2uH8Wz3ryGNRtYN0uheqhky09LY1EK8EahyvrLefRdB8BLNbFGB9FMpmaK
         2JYsjUQ6qoKsF5k8rEgBPqOJ/wBYC3CcSG/ILg2UU5B8g7FuoGVD/J/ryykK4Mx31feT
         TNihCZdRwlj5+QFhtk+isJuZUTbnis0ctp3pkO6KhqnNP4Joqd2/TtEVt/6SOZv5nrnM
         QSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793278191; x=1793882991;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ROp3jZYajDVDh8nm32pw5xyIgzSFtN3IpqGpjVrWuQc=;
        b=0njFoMTfEkGdV/4bwDb8NgQKR2liN7HZYQYoNUnwFgteEGZtIaVtFHbxchMqPkrj7S
         08U9Ih9VEc/Dn6EXf2VEdwdgE2JfEv1tX0IwAntn47VGWZRONwsXuoMHfoCpXmd16/Dk
         h/CWo7nPcSEpHgOmkqclXOUs6TouqkQP5YrNw/30CO4UBTMMVSFohY0hDKNoISpMcse2
         VxuMT7JpfAcSzwV/rxgmF3JI+ex/qI9syz/iwU09hxM2UQL+90zdeo9zVbqB0Sc1x9tc
         GXiI4lg6KIq4OvYlllT4jmcqL4XiYrfkVZy5HNTXGrsF7lYKWXDHrLnxYLwLBUAaljD3
         cXew==
X-Forwarded-Encrypted: i=1; AKwUvBwH4MgwRPdUV2Fpb/wyClOdfMTkeWJ6nH5kLLT96K4U8t/nj1eMJvQ0teBN3g52NYk0pMlOuJ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJljFCxLPkoYp6+YwpHH9fEbC92XFwHMxCzttip5iFZdzAQmf5h
	l2Bk91s3TWkqaslnBrLbqSPX3ZQqM+P5VUTGbYv12Me1g7FvhNAE2DbX
X-Gm-Gg: AYBFou3m6tuLhjevdlFe5+l1bB3O2r7utJIA8cQCUSghoxdZAwoPVG3QNn85y9hkTB4
	NAcaTJVauMxNb96nZzJMpx2wRMV+btKAQ1KzX2WL3Wkiy977A7SY/VCZ8SMD1NRNHMUQ6zjYOnO
	qfg+Hz+11EeTeiVMhPi0l3tfdqhWPNWA7jV2JfVf9u/jugTDZZDcX9LV7JZEN3xlvZrW0hx2ukE
	0LG08zl0u2qteYaRjQx/RCArsDsILF776fTaaGj7gM+D+Y5AFUBoWOEkkWAFv4b/tdA8Dh8mThr
	c7w03ckjO8ykjudKJjdcYJRrlDDNKQ1dYeoVnSCfjuZNjMpIKFPzOxJAit19+hdRo6A+GOoQIiC
	d7s01EofAU2x0fyXWhbyuLhJVt2rWPnTqvxArMe8Q8UrOdEhT0RI+a/Afw3bmbhI2Kpo5VBuP8m
	hedQ6zP9LckIegQbCR+VBl+eD2UpEvxU6ZHEbVveeiccybSjOr1sIMZvY9NzroZVDQ0UR++MFUz
	rjwrn0IsupAnDRMfO4cQ3/W7fjnNdLJX+AQmLEyh54XqoBGIOjs2cUeQi53lcoa0BpFEaoqXJlB
	U7ZBwcq7nwE2UeZO2orP/2tnjZL+oIPQ3MvPfw08g+IfPZ6LUUeCAXiSCB6H4KrnJEAwgouIIoY
	9dh1sMxnRX+tj
X-Received: by 2002:a05:6102:442b:b0:7cc:2712:caf2 with SMTP id ada2fe7eead31-7d03a58ef68mr2795290137.23.1793278190871;
        Thu, 29 Oct 2026 05:49:50 -0700 (PDT)
Received: from [192.168.15.16] ([2804:1b3:a2c1:77a1:5cd:8fee:f3c:4da7])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9913af7aa6esm3225638241.4.2026.10.29.05.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 05:49:50 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 syzbot+2e3c70a51d4ac0f6bdd9@syzkaller.appspotmail.com,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] SUNRPC: serialize pipedir removal on the
 rpc_client_register() error path
Date: Thu, 29 Oct 2026 09:49:40 -0300
Message-ID: <179327818020.63233.759139320736692367@gmail.com>
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

When rpcauth_create() fails, rpc_client_register() calls
rpc_get_sb_net() and then __rpc_clnt_remove_pipedir() whether or not a
pipefs superblock was found.  If rpc_get_sb_net() returns NULL, the
removal runs without sn->pipefs_sb_lock, and the client is still on
sn->all_clients until rpc_unregister_client() a line later.  Pipefs
mount/umount notifications run under pipefs_sb_lock and walk that list,
so they can race with it:

 - a pipefs mount between rpc_get_sb_net() and rpc_unregister_client()
   gives the client a new directory, which the unlocked
   rpc_remove_client_dir() then removes while a concurrent umount of
   that superblock drops the same dentries in select_collect_umount();

 - a umount notification that picked the client up before it was
   unregistered keeps using it after rpc_new_client() has freed it.

syzbot hit the first one when racing rpc_pipefs mount/umount with
NFSv4 mounts (the krb5i rpcauth_create() fails without the gss mech):

  WARNING: fs/dcache.c:1063 at d_make_discardable+0x28e/0x2f0 fs/dcache.c:1063
   __simple_recursive_removal+0x276/0x5c0 fs/libfs.c:625
   rpc_remove_client_dir+0xf0/0x140 net/sunrpc/rpc_pipe.c:898
   __rpc_clnt_remove_pipedir net/sunrpc/clnt.c:100 [inline]
   rpc_client_register+0x605/0x6f0 net/sunrpc/clnt.c:333
   rpc_new_client+0x977/0x1300 net/sunrpc/clnt.c:437

With a test-only msleep() after rpc_get_sb_net() returns NULL, the
syzbot reproducer also triggers the second one:

  BUG: KASAN: slab-use-after-free in rpc_pipefs_event+0x568/0x57c
  Write of size 8 at addr fff000000ec53240 by task rpc_repro/107
   rpc_pipefs_event+0x568/0x57c
   notifier_call_chain+0xfc/0x384
   blocking_notifier_call_chain+0x68/0x9c
   rpc_kill_sb+0xbc/0x1a8
   deactivate_locked_super+0x98/0x11c
  Allocated by task 111:
   rpc_new_client+0x144/0xf04
  Freed by task 111:
   kfree+0x1dc/0x5c8
   rpc_new_client+0x9f8/0xf04

Do what rpc_free_client() does instead: unregister the client first, so
no later notification can find it, then remove the directory with
rpc_clnt_remove_pipedir(), which takes pipefs_sb_lock (waiting for a
notification that is still running) and only removes it if the client's
superblock is the current one.

Fixes: eeee245268c9 ("SUNRPC: Fix a deadlock in rpc_client_register()")
Reported-by: syzbot+2e3c70a51d4ac0f6bdd9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2e3c70a51d4ac0f6bdd9
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Yaga Agent HackerSec Claude:claude-opus-5-5
---
Tested on Linus' master c339f4010dea (arm64, QEMU, generic KASAN,
PROVE_LOCKING, NFSv4 without RPCSEC_GSS_KRB5) with the syzbot C
reproducer.  The race window is narrow: the plain reproducer did not
hit it here in 6 runs, with or without this patch.  To widen it, a
test-only msleep(20) was added on the err_auth path (after
rpc_get_sb_net() returns NULL in the unpatched code, and between
rpc_unregister_client() and the removal with this patch):

  unpatched + delay:  2 of 2 boots, 16-22 WARNINGs each (mostly
                      d_make_discardable, plus fast_dput, and umount_check /
                      generic_shutdown_super once) and one KASAN
                      slab-use-after-free each (rpc_pipefs_event in one boot,
                      rpc_create_client_dir in the other)
  patched + delay:    3 of 3 boots (9 runs), no WARNING, KASAN or lockdep
                      report
  patched, no delay:  2 of 2 boots clean

net/sunrpc/clnt.o builds cleanly with W=1.

 net/sunrpc/clnt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 6cedc82..16aff2a 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -328,12 +328,18 @@ static int rpc_client_register(struct rpc_clnt *clnt,
 	}
 	return 0;
 err_auth:
-	pipefs_sb = rpc_get_sb_net(net);
+	/*
+	 * Unregister first so that a concurrent pipefs mount cannot give the
+	 * client a new directory, then remove the directory under
+	 * pipefs_sb_lock like rpc_free_client() does.
+	 */
 	rpc_unregister_client(clnt);
-	__rpc_clnt_remove_pipedir(clnt);
+	rpc_clnt_remove_pipedir(clnt);
+	goto out_destroy;
 out:
 	if (pipefs_sb)
 		rpc_put_sb_net(net);
+out_destroy:
 	rpc_sysfs_client_destroy(clnt);
 	rpc_clnt_debugfs_unregister(clnt);
 	return err;
-- 
2.39.5
