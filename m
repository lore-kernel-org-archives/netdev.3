Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792667765;
	b=2ovgFgGok0lTDDPPDEyehWpacqLddKcMmH7cDGHQUR1jKlVfsDCKHE0BH9ARXwKfdG/c
	 VNynUhbd+7WKtM/s8V5gj0onxnKSmrHigfrIfIr5vG5V5PDDG6oE3eU+0BpnIx41JpD/Y
	 GND0KhggElYbfHUP+sbCeKV6lGBgI5qfs6R+1ViOAgxGep4S8DJ5c5j0Oo6+EzukHSgLC
	 nvq7fCCbGk9pxNTF2JM2dNCgLFyQVLy81aZMilnlY9C+rPsF12XDQkJkblfxV1rMFTsFP
	 r16xa96BS+/CmPnH2ZzzNoLdl4prLOL22CRvUaHLcVO+6uvg7A39T0nP73moWZ1K81Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792667765;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BrtZdZuRvHE7UaprIXjohtPs6I5PYcsDi23QTQ2VB7k=;
	b=uMxdbWv/eVL8Pe7UJy0065oIsh1PWkha4mucG4mI1an9FWwJ75/hmTvmnzZpcibjFalk
	 jbOCybGzp9Zwn64g4YbzSslKjP/hr9QcVZK7M+rsUTBS3o5MdJumPZbyXIM1GUyJ+WBok
	 yayUFmC3Wi65wx2HxgqACvQrgiXMa43az1zPcSy64lLvLGafQsG4oVHWg4MBzZkJo6wfV
	 PR3niRc2b7BbqJbRx8FbFWCLM1H+75qCLSmbroSMf4SwdcZMC9jsoLg3JIVpa4iJehHQo
	 EAaj+Np1K6XkFMx0HDk5HSj90n7VlgWNoxa0n1oCvr5VO63Nw11UYWsy0BlyX6N+yLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A2rz3DNx;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF69606A31B
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 11:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FF69606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A2rz3DNx
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48c5358fc28so1453738f8f.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 04:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792667762; x=1793272562; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BrtZdZuRvHE7UaprIXjohtPs6I5PYcsDi23QTQ2VB7k=;
        b=A2rz3DNxOwpE516/gjaffiFW2OJnETBppxpXTf4DPLWLfx06LkqXLJwSbh5QQ+T6Mc
         NlJdvi0RQIwBoacbSuY18ZfApEzw3ubQvSGBmyYOvSxKod9IGl9rAC/y/eBfi9QyZfMm
         9ViZeKOXzsVWsFARih1caoOSPo1ARCS6eoIiFKC3UJQMntv7eLMeKF9tHSMUSLzJ1Hcs
         KswjoysneqomW7hLU+46Wu7dhbFBcFMuaMignWAzWnxewBWd+sl7LwlNxTJcxZbiHV5r
         2aRpidu9HblJIYa5si0diJJGMGU4bTw+gTDM6y+FT2WAnB1NMBhZBQjqGqKpOcO6g2nw
         XvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792667762; x=1793272562;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BrtZdZuRvHE7UaprIXjohtPs6I5PYcsDi23QTQ2VB7k=;
        b=2JkpB+QBMXqZUMFclwfnZHt1hMA86eJfja+QFIgQISZ1ocuhiT/VNVX/h8Eswf2ON+
         59cAb+3mYOr4lg7xOphbn4Rr3Kbx2kDTtAK1+wWo91OuO5WLIyx1PTR5FeyPUJY1h5r3
         zxh8U02jOE+gH0uyuGlxdMHVVB4lOUoz2Rzu38+QJEyIZcti85HFzHzn7rpyUu5xejlH
         YbraHeI6HuvETttk1wihDUsIk2vnvlzMA4tGbWLI6k1BmjM7WAjvQjHY8ZuApIhzV3SZ
         9yOE23tYIw2vJNe4lFRDPf1d2DkypAWBpC0cHWMBdy/54RqoR4TpnGVMGO17d5qqxImL
         4nIA==
X-Forwarded-Encrypted: i=1; AKwUvBy11IXJKqLrrUQoTGmn3bIkZiNpaxUsAOqpQh2W41Av8t8LAcU1duW2NB1MgUohlYBEnrLJxT0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLlo4k+meQMqX6YDO56IYvJtUHKXDbyf9GMfDI/eeWDXTwtFFp
	s1NvL6TROssX394Y2CCQ4U+4b/DfIMGk3lKnSEKj6dJyHRnD3EpMtaw6
X-Gm-Gg: AYBFou0PQqwIJl/J+E3akUANhnMn/ypiaqEso+awxzNz86eBsQt5sH5a2ayMOdHqxRt
	FpCGgSas8e8b1NNBQBXI1uqOCGej4tWSS7c6ihv5b2EKOM5Zq1B7ri24LLW5ylN1m8uqdPStROs
	BMY44cMgbv+/XQE8QXRDmArGCR0GggdAWAt0uN2q5BMhy+xquBYNwXdfLwo+PPxBXPsIUVrw+81
	f5JC+U9VmvIHoeR1Q/3mKW2HXknuHDvuQG2j9clAWjI4V1c/TaURttzkgPzCsUpHhbaSaNsNhwG
	9bUq3nllER33vb4Lu2nh4scrgIz0LsN8xUwnZRKOFAzH9UgdYHXhhX3eHmo7dfNdynvH0fYXNN2
	FNmKQDEfaaxmHC8o4HyVRWNRWLbWdW7OCyqtXUdODXAQW8+V1Th2Cf4gyV97ARBtYBpEslP87Lz
	Y3KyTVTqrNtoVF4OZWdCO6rJ31iXN5rXcymmY4QuYU09citlZNWaI4wfAEVyHKFMC1U1iEj/xdH
	jMIrg5XSHcNb9jPnaqVDWCJR8FdHops+t8VjWqmUFparyTxMRmCt7b1uvN2Ic1iaYfj84g2xqXE
	5yIUEQk5h/BYI63KOup17y+UUoSpWoIw3VGVGZ2dfFm32LkYoyhUSs3+zhLcXbCrtLowFJuY
X-Received: by 2002:a05:6000:1861:b0:48e:cd3:b3ec with SMTP id ffacd0b85a97d-48e264bc4a3mr9591983f8f.28.1792667761957;
        Thu, 22 Oct 2026 04:16:01 -0700 (PDT)
Received: from emanueleg-nb.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828c6dsm12536753f8f.24.2026.10.22.04.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 04:16:01 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	regressions@lists.linux.dev,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Subject: [PATCH 6.12.y] net: call getsockopt_iter if available
Date: Thu, 22 Oct 2026 13:15:21 +0200
Message-ID: <20261022111535.528099-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.53.0
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
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

commit 5bd0dec150f56b6307d599132dcb7c01007bbecc upstream.

Update do_sock_getsockopt() to use the new getsockopt_iter callback
when available. Add do_sock_getsockopt_iter() helper that:

1. Reads optlen from user/kernel space
2. Initializes a sockopt_t with the appropriate iov_iter (kvec for
   kernel, ubuf for user buffers) and sets opt.optlen
3. Calls the protocol's getsockopt_iter callback
4. Writes opt.optlen back to user/kernel space

The optlen is always written back, even on failure. Some protocols
(e.g. CAN raw) return -ERANGE and set optlen to the required buffer
size so userspace knows how much to allocate.

The callback is responsible for setting opt.optlen to indicate the
returned data size.

Important to say that  iov_out does not need to be copied back in
do_sock_getsockopt().

When optval is not kernel (the userspace path), sockptr_to_sockopt()
sets up opt->iter_out as a ITER_DEST ubuf iterator pointing directly at
the userspace buffer (optval.user). So when getsockopt_iter
implementations call copy_to_iter(..., &opt->iter_out), the data is
written directly to userspace — no intermediate kernel buffer is
involved.

When optval.is_kernel is true (the in-kernel path, e.g. from io_uring),
the kvec points at the already-provided kernel buffer (optval.kernel),
so the data lands in the caller's buffer directly via the kvec-backed
iterator.

In both cases the iterator writes to the final destination in-place at
protocol callback. There's nothing to copy back — only optlen needs to
be written back.

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Link: https://patch.msgid.link/20260408-getsockopt-v3-2-061bb9cb355d@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
Clean cherry-pick of the upstream commit, no changes. Needed in 6.12.y
only.

v6.12.114 picked up commit 41fbf726915b ("net: add getsockopt_iter
callback to proto_ops", upstream 67fab22a7adc) and commit 22ebe6ab0b67
("Bluetooth: L2CAP: convert to getsockopt_iter", upstream bf01627cc04b)
as dependencies of commit 3af72bf8f73c ("Bluetooth: L2CAP: access
chan->conn safely in get/setsockopt", upstream ca2c4c264986), but not
this patch, which is the one making do_sock_getsockopt() actually call
->getsockopt_iter().

Since l2cap_sock_ops no longer provides ->getsockopt, every getsockopt()
on an L2CAP socket at SOL_L2CAP/SOL_BLUETOOTH level fails with
-EOPNOTSUPP on v6.12.114. As a result bluetoothd never registers the
adapter and bluetoothctl reports "No default controller available":
BlueZ's btio calls getsockopt(L2CAP_OPTIONS) while bluetoothd sets up
the BR/EDR ATT listening socket of the GATT database, and the adapter
is dropped when that fails. Our CI sees this on every Bluetooth-enabled
board running v6.12.114 (i.MX 8M Plus and AM62 based, BlueZ 5.72),
while v6.12.113 was fine. The same regression was reported with an
Intel AX201 on Debian 13:
https://bugzilla.kernel.org/show_bug.cgi?id=222177

L2CAP is the only user of ->getsockopt_iter in 6.12.y. The other stable
trees either did not get these backports or already contain the
upstream commit. The patch applies cleanly on v6.12.114.

Tested on a Verdin iMX8M Plus with our v6.12.114 based kernel plus
this patch.

The root cause analysis (comparing CI logs, reviewing the
v6.12.113..v6.12.114 changes and reading the BlueZ code) was done with
the help of an AI coding assistant (Claude); I reviewed the analysis
and the backport.

 net/socket.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 723bc3a1ba5c..b8d662e19310 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -77,6 +77,7 @@
 #include <linux/mount.h>
 #include <linux/pseudo_fs.h>
 #include <linux/security.h>
+#include <linux/uio.h>
 #include <linux/syscalls.h>
 #include <linux/compat.h>
 #include <linux/kmod.h>
@@ -2345,11 +2346,45 @@ SYSCALL_DEFINE5(setsockopt, int, fd, int, level, int, optname,
 INDIRECT_CALLABLE_DECLARE(bool tcp_bpf_bypass_getsockopt(int level,
 							 int optname));
 
+/*
+ * Initialize a sockopt_t from sockptr optval/optlen, setting up iov_iter
+ * for both input and output directions.
+ * It is important to remember that both iov points to the same data, but,
+ * .iter_in is read-only and .iter_out is write-only by the protocol callbacks
+ */
+static int sockptr_to_sockopt(sockopt_t *opt, sockptr_t optval,
+			      sockptr_t optlen, struct kvec *kvec)
+{
+	int koptlen;
+
+	if (copy_from_sockptr(&koptlen, optlen, sizeof(int)))
+		return -EFAULT;
+
+	if (koptlen < 0)
+		return -EINVAL;
+
+	if (optval.is_kernel) {
+		kvec->iov_base = optval.kernel;
+		kvec->iov_len = koptlen;
+		iov_iter_kvec(&opt->iter_out, ITER_DEST, kvec, 1, koptlen);
+		iov_iter_kvec(&opt->iter_in, ITER_SOURCE, kvec, 1, koptlen);
+	} else {
+		iov_iter_ubuf(&opt->iter_out, ITER_DEST, optval.user, koptlen);
+		iov_iter_ubuf(&opt->iter_in, ITER_SOURCE, optval.user,
+			      koptlen);
+	}
+	opt->optlen = koptlen;
+
+	return 0;
+}
+
 int do_sock_getsockopt(struct socket *sock, bool compat, int level,
 		       int optname, sockptr_t optval, sockptr_t optlen)
 {
 	int max_optlen __maybe_unused = 0;
 	const struct proto_ops *ops;
+	struct kvec kvec;
+	sockopt_t opt;
 	int err;
 
 	err = security_socket_getsockopt(sock, level, optname);
@@ -2362,15 +2397,28 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
 	ops = READ_ONCE(sock->ops);
 	if (level == SOL_SOCKET) {
 		err = sk_getsockopt(sock->sk, level, optname, optval, optlen);
-	} else if (unlikely(!ops->getsockopt)) {
-		err = -EOPNOTSUPP;
-	} else {
+	} else if (ops->getsockopt_iter) {
+		err = sockptr_to_sockopt(&opt, optval, optlen, &kvec);
+		if (err)
+			return err;
+
+		err = ops->getsockopt_iter(sock, level, optname, &opt);
+
+		/* Always write back optlen, even on failure. Some protocols
+		 * (e.g. CAN raw) return -ERANGE and set optlen to the
+		 * required buffer size so userspace can discover it.
+		 */
+		if (copy_to_sockptr(optlen, &opt.optlen, sizeof(int)))
+			return -EFAULT;
+	} else if (ops->getsockopt) {
 		if (WARN_ONCE(optval.is_kernel || optlen.is_kernel,
 			      "Invalid argument type"))
 			return -EOPNOTSUPP;
 
 		err = ops->getsockopt(sock, level, optname, optval.user,
 				      optlen.user);
+	} else {
+		err = -EOPNOTSUPP;
 	}
 
 	if (!compat)

base-commit: 85d82e0d7c2dfd3e75d34f35b7ebbf41f45c9c4e
-- 
2.53.0

