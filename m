Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527BB2FDC5E
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784985783; cv=none; b=N0hKmCTV9VhbCdWYqRVIuhjJHki8zPLnnvRCQS97GVdnJbUs9WLlxZeQAVdGS9daTPbu6D1SxRBM2TGtPU33mz9ESv9cYj5xqCYfFKtm4GI8uClgC0MD19fFu3r/3z1SuXwt1WqDqb6CXG3FAuBu0Dt5ce+0SQC17TGKuxNs/TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784985783; c=relaxed/simple;
	bh=97xEWqQxd3MflF43LClPkOQcYakWonr25YhX/9+k8g4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=efd+2N8u6KKm55OnYj9CwaM8NOXH0qsT56a6kEsMhV3Ex5udW72s0N/5j9xV6AkqsQo52/xU22xDqE3QZbV+W46RM1SflIDz6UrSnRbbp3K3BSxOsWW7uPM9acq/Z7VrKf3QnmcRVKH32NnvAosJk6H2uz6cEpgbpg4h43JMajw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dy+PbgFA; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dy+PbgFA"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b0231a3e86so1167115e87.0
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 06:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784985780; x=1785590580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sIDqT1SiBF4RoBKhu5UCLRHokUDL3DRTBfD3SKYOjqE=;
        b=Dy+PbgFAmDMpHkfXRRemm/zrDSlmVMf1SPDrDfFX5S8ku2zIBVIlb5PQFyeQEKmhfy
         FifyCR0gAaXFmoWJF/yX+DE5XJNkkQQ9nhbHXcncLzg28z7RYR1tHe+khNJ5OkbKgBgi
         Q+H9bC3sVR014gTxqH6iu0eGJUZZh6DPiSUx+kS1nqGGnI7mde37lg5k18TJw9TiO/Qw
         g8OtGddk4L0fNAglc9Z48GVOwuZgudrZqaM3s5Ot5RmUZ8D/Ybxbm/GxMOTYp5fnubyd
         wYSKMpvRpO7WTd4829PK2E7OzqsUTtqNfu6TmuYQPCBq8tiFmCR8GNawERfaroESaCDY
         Q2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784985780; x=1785590580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sIDqT1SiBF4RoBKhu5UCLRHokUDL3DRTBfD3SKYOjqE=;
        b=FVCFTPUVUQviQQW6Te1yhRquGEEhHU1PcRX3T4z6euUHpAe+Soc4M/vYnc0nUGs3oy
         zU5JdReEXV9uaKrlJ9x07y9j0/mvFmzKH1KH1i6zyZzcUJbPY9kxg4VIR8EtpmFY8D5O
         ofZfhpvEkSQmeyT/uoSixKG2dWEwq9Lbax1uIhBa7x9b0o2F0s9+N9NUa8Pon0CSsuUj
         NV/JuD2KLP9cXwfoVrN9O1upk3Ar0vHOdAOSjA7l5HxmYZYRUWkmnrMltjVhjyBPivRK
         Nz1cSw+F0iRHY4y0FlW5sWo9JZLW02lw6SH83HXbG9lev3gQTZBbkjPj5hTeZnfb38o7
         LVRQ==
X-Gm-Message-State: AOJu0YwdG46jVv7kr1bwXBJKecajsUBEfc/Wi8Iz+mleJfetL8JhDc22
	Z2mJRzXzlyxQjYjnPm7RpSK+Xtmv56hmOefEJ0d2kKpV8N33ifmp5/+4qxZilwWLoJE=
X-Gm-Gg: AR+sD10w0UX52oZHh05ht+lvSm310vf7+Q54TDlE7wl6ATXfLHse9DuzTDZIBHENKsr
	E/NJnlOedVHxcL0BkWoIzFSp2C9tVLsiygwvnqv0sB/DjAG6BIF5P1WCRGp9EP/+YIHHy4bESgq
	WeA6IYVR3pEXUFDUCQZk1JYjGLas5PbIDZ4G207lAhsu5yaFUVX7H13rZNxku0AAcAgj1pYUO6J
	UK8505Vd2anwTYWaQouY+nBJkvzEJV2s1rui0lKyVq1svsWF8Yws1ZnYWDlcEIRFgz3JcjRDCeX
	OOsUOMausoI8dXPKMaqtKn+YkgmIuopgnjtj/0Gp6W5SNMGl5a9rMKNncikyDqOhoWiYjO9QCYb
	phkKAcO4/oh1Cdn6LVbKyb7EeYE9JcmMM3tuitIuMxYrmRmGprdwFQVWfhTA/jLuA97ZSSReq8T
	HJHVwUsfM9XmzA6DOk+SdLtWDMd9dZcJN1pFH27ZLC/Hc2/yLS4C4zMIbVGNAelO528t4hOqrNf
	HWlCs7VqjqfIyk=
X-Received: by 2002:a05:6512:2303:b0:5b0:215b:5de8 with SMTP id 2adb3069b0e04-5b2c1b532f4mr365011e87.64.1784985780219;
        Sat, 25 Jul 2026 06:23:00 -0700 (PDT)
Received: from localhost.localdomain (46-138-176-102.dynamic.spd-mgts.ru. [46.138.176.102])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2be083db1sm434092e87.25.2026.07.25.06.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 06:22:59 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	chrisw@sous-sol.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] rtnetlink: truncate IFLA_VFINFO_LIST instead of overflowing its length
Date: Sat, 25 Jul 2026 16:22:36 +0300
Message-ID: <20260725132236.88318-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtnl_fill_vf() closes the IFLA_VFINFO_LIST nest with nla_nest_end(),
which stores the accumulated length into nla_len. That field is a u16,
so a nest larger than 65535 bytes is written truncated modulo 65536.

The skb is sized by if_nlmsg_size(), which adds rtnl_vfinfo_size() for
every VF, so the buffer really is large enough for the whole list and
none of the nla_put() calls in rtnl_fill_vfinfo() fails. The overflow is
therefore silent. Userspace then walks the message with RTA_NEXT(),
which advances by the stored length, so parsing resumes inside VF
payload and the top-level attributes that follow the nest are read out
of VF data. Those are IFLA_VF_PORTS, IFLA_XDP, IFLA_LINKINFO,
IFLA_PERM_ADDRESS and IFLA_PROP_LIST. iproute2 prints "!!!Deficit", and
strictly validating parsers reject the message outright.

rtnl_fill_vfinfo() emits 296 bytes per VF on a 64-bit kernel with
efficient unaligned access, so the nest wraps at 222 VFs; without
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS it is 328 bytes and 200 VFs, and
with ndo_get_vf_guid 336 bytes and 196 VFs. ice supports up to 256 VFs
per PF (ICE_MAX_SRIOV_VFS), so this is reachable on shipping hardware.
Requests that set RTEXT_FILTER_SKIP_STATS need 335 VFs, which the 256-VF
limit puts out of reach, so plain "ip link show" is fine today while
"ip -s link show" is not.

On CONFIG_DEBUG_NET kernels nla_nest_end() now also splats via
DEBUG_NET_WARN_ON_ONCE(), added along with nla_nest_end_safe() in commit
1346586a9ac9 ("netlink: add a nla_nest_end_safe() helper").

Using nla_nest_end_safe() here would not help: a nest that does not fit
in a u16 will not fit in a retried skb either, so returning -EMSGSIZE
would turn "ip link show" on such a device into a hard failure. Bound
the nest in the writer instead, as suggested when this was last
discussed: drop the VF that would push it past U16_MAX and end the list
there. Userspace sees IFLA_NUM_VF unchanged and a shorter
IFLA_VFINFO_LIST, and everything after the nest stays parsable. An empty
nest is already emitted for a PF with no VFs, so a list shorter than
IFLA_NUM_VF is not a new encoding.

The other large nests in rtnl_fill_ifinfo() were audited and cannot
overflow: IFLA_AF_SPEC is bounded by a handful of address families at
about a kilobyte each, and IFLA_VF_PORTS would need more than 560 VFs.

Fixes: c02db8c6290b ("rtnetlink: make SR-IOV VF interface symmetric")
Reported-by: Jacob Keller <jacob.e.keller@intel.com>
Closes: https://lore.kernel.org/netdev/16b289f6-b025-5dd3-443d-92d4c167e79c@intel.com/
Assisted-by: Claude:claude-fable-5
Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 net/core/rtnetlink.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 12aa3aa1688b1..bd1d65dcf42fd 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1687,10 +1687,22 @@ static noinline_for_stack int rtnl_fill_vf(struct sk_buff *skb,
 		return -EMSGSIZE;
 
 	for (i = 0; i < num_vfs; i++) {
+		unsigned char *mark = skb_tail_pointer(skb);
+
 		if (rtnl_fill_vfinfo(skb, dev, i, ext_filter_mask)) {
 			nla_nest_cancel(skb, vfinfo);
 			return -EMSGSIZE;
 		}
+
+		/* An attribute length is a u16, so the nest cannot describe
+		 * more than U16_MAX bytes. Drop the VF that would overflow it
+		 * and stop: a truncated list keeps the rest of the message
+		 * parsable, whereas a wrapped nest length does not.
+		 */
+		if (skb_tail_pointer(skb) - (unsigned char *)vfinfo > U16_MAX) {
+			nlmsg_trim(skb, mark);
+			break;
+		}
 	}
 
 	nla_nest_end(skb, vfinfo);

base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
-- 
2.43.0

