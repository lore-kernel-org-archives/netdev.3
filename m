Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A6C3C8732
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786362416; cv=none; b=SGSOWZtD2qqkaiXM2A+k9YjwUwA+y8S3ra80SPh1wVDA4cGQHb8p+f/50sREeROQrvDywd0x3ZKHpzRXbNym3g6reVReHROq54yv5yuDBl2E7zdgbKzrwPtxXpLPtU4YO4kKIeiXiyBMU+BVFxem57MbjH/3Q00z/k2b2v4uibs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786362416; c=relaxed/simple;
	bh=FqSKut/NeF+jbTcveYFebP/x9+OUciEE4qfDOf5tz1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kgJuJUvdXCBTWRvxUUYYkFmcSSZ+Ho1s32l5Of+jGWsBPstjOoV9chWLGukVPkl+lvqBNP8It0CsJgQvGsPp8J/c32ffErjbq44zrhoPpMgGXJb33lcu+Nq671lqh29/nxciHDH11nTpZUQ7vXW/coF5tJRNG97jUaSxUYZP7Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuphID5X; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuphID5X"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso959834a12.2
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 04:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786362414; x=1786967214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5csJ5l5RsA5RzZR3PB83eVZukyO/ayF8j669uOpiolA=;
        b=VuphID5XjXW4a/BQ59UZATgQoFbWcHABAAOQb6gNFN/ROc2N9aiYBVAMu9VjvrRS55
         r9U2AjLm1tjNPO0bOMSvEm0umt58Ocs1++iIJ3dTETEKk3jOg/De+q5AHSNdjYv6bbio
         K0unluTjlNJ0JcC+mcCr1uTzUQYXgG0G2XOcCnkPfN9knhiF6pmG2foLFK9/4t5KO+ej
         9ZA1jAZpJWYvn9+STh3Spsz+6yi6L4q49gaLh+zbqjEKoxj9h7nOuwVFqacAe8cHLmry
         kK04Swa1KNDBj/CSN0gvoIXfGAWXcj3FT0E7RkrKmLhLAMh7eGF0LKNWDrH3IcZ3FFsG
         XwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786362414; x=1786967214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5csJ5l5RsA5RzZR3PB83eVZukyO/ayF8j669uOpiolA=;
        b=GrLhUq7v7QOQy8oNkUx4YkHP7+S97N6GZciCk4trkGUZS72Of62n/0sz8s3ORJKk7t
         xSwGUQF33+TCaOKU8aKo/12LnfsEANbjIqu6u66uJP1drjfZu6YqpeJXEpCxeXmJvJW6
         u/+ZSIPGbPjNm2fOOoqX/VzCzBNf2qIYFIXNbzeO9vjs6WAwea4RlbwOXzVn4sISpwvE
         k3+rQRQ2FIV5nIlB3BzzdO+zyjHwDa31QPgUtOU10qzw/unSw/7z/lvF0ExoXtyopg48
         Sag77kKx6mjRMqdTy9h1kev/8DTeOSi+w80pgWhFLq5LM+NX9ngAP/4QIKP2/Ny877WE
         s5Hw==
X-Forwarded-Encrypted: i=1; AHgh+RpI9E6ZaoBh5uYtktEHVVHIgHpsOZwSCO4VyBfw0gMl/xlfE/P0/OzJXn4JRBzgJNqVQKZJwEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRDHFED1YzaTZzE3uFI8T7UbxjyZXPZL5lRrqJAwSA0gCPQ39r
	o/O779Cyvf5IGt6vE9X7sa+Qd7wMV9AHNmtnQqocIvPFo/wemZvWVNuD
X-Gm-Gg: AR+sD12EVhV91XZ30SvenBols/4SehIgQsG6pbnfbsAHzjOHFOOl4hmzU/fKTZEcKfi
	5xdEL1VPGqtodHhL+TywClW4pMBXEuinWuH2mS3Fibj7h2qyd5/QHfTni8hDXT1oaPz4dOivzLQ
	j5MnVJRGrINm7liiv6zlw1U5K7P9vxjHNtingDiWUMxOCgCAOCliNw50oK9e/Hq57HKBXYUqkV0
	JuMfeHJxX6QswE5QJcaV9EKM5pyxxXcM1B7xeY7WixHma9fnyikxDjuf3RHGxEw1aJWQ168HsOc
	cN4GgzPkTGdOdZrV4R+52s8cvznkrqrPaw2vS0iTrSzmqi28bcfV84ZgaholsakXuEP4KzoqTTU
	nw3amuuZUWb7e4pFKNicYPLk8ysq1TEYlDcNyCla+YgbXCRDm95pSdPAzfMfbIKu+2SzBUaRQv4
	qLzEFNk5OXQJNmkIT1nu5PnQVvb1EXD4WwcSG5bCScgxtjYmbFoIp/NevFiqHI2m0nqLGNfop6U
	45KLw==
X-Received: by 2002:a05:6a21:3117:b0:3b5:489c:7bb5 with SMTP id adf61e73a8af0-3cbadc97c22mr37147925637.28.1786362413580;
        Mon, 10 Aug 2026 04:46:53 -0700 (PDT)
Received: from TENCENT64.site ([103.7.29.106])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f38b7d9sm3793305a12.32.2026.08.10.04.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 04:46:53 -0700 (PDT)
From: Fourie Zhang <littleddfu@gmail.com>
X-Google-Original-From: Fourie Zhang <fouriezhang@tencent.com>
To: matttbe@kernel.org,
	martineau@kernel.org,
	mptcp@lists.linux.dev
Cc: Fourie Zhang <fouriezhang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Peter Krystad <peter.krystad@linux.intel.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Christoph Paasch <cpaasch@apple.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] mptcp: reject a DSS option that follows an incompatible suboption
Date: Mon, 10 Aug 2026 19:46:10 +0800
Message-ID: <20260810114616.2709245-1-fouriezhang@tencent.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All file:line references below are against v7.2-rc4 (ac5b0e5651b1). The
KMSAN trace was captured on 7.2.0-rc6-kmsan72rc6 (075b74841bd0), where the
same lines apply.

mptcp_parse_option() writes the DSS status flags before it validates the
option length. For MPTCPOPT_DSS it assigns dsn64, use_map, ack64 and
use_ack at net/mptcp/options.c:160-163, computes expected_opsize at
:165-180, and only then rejects a bad length with a plain break at
:190-192. That break leaves use_map set.

OPTION_MPTCP_DSS is a separate, sticky bit set at :194, and the mapping
fields data_seq, subflow_seq and data_len are written only inside the
use_map branch at :207-220, i.e. after the length check.

mptcp_get_options() clears only the four-byte status group
("*(u32 *)&mp_opt->status = 0", :370). data_seq, subflow_seq and data_len
are declared ahead of struct_group(status, ...) in struct
mptcp_options_received (net/mptcp/protocol.h:145-177), so they are left
uninitialised, and the caller declares "struct mptcp_options_received
mp_opt;" on the stack (:1137).

So a single segment carrying two DSS options -- first a well-formed
ACK32-only DSS, which sets OPTION_MPTCP_DSS but no mapping, then a
truncated DSS whose flags claim a mapping, which sets use_map and then
fails the length check -- ends parsing with OPTION_MPTCP_DSS set and
use_map == 1 while the mapping fields were never written.
mptcp_incoming_options() passes the OPTION_MPTCP_DSS test at :1210 and
copies them into the skb extension at :1253-1258; get_mapping_status()
then branches on the uninitialised data_len:

  BUG: KMSAN: uninit-value in mptcp_subflow_data_available+0x2428/0x4c70
   get_mapping_status (net/mptcp/subflow.c:1152)
   subflow_check_data_avail (net/mptcp/subflow.c:1369)
   mptcp_subflow_data_available (net/mptcp/subflow.c:1466)
   subflow_data_ready
   tcp_data_queue
   tcp_rcv_established
   tcp_v4_do_rcv

  Uninit was stored to memory at:
   mptcp_incoming_options (net/mptcp/options.c:1258)
   tcp_data_queue
   tcp_rcv_established
   tcp_v4_do_rcv

  Local variable mp_opt created at:
   mptcp_incoming_options (net/mptcp/options.c:1137)

  CPU: 0 UID: 1000 PID: 137 Comm: poc 7.2.0-rc6-kmsan72rc6 #1

Reject a DSS option when an incompatible suboption is already present. The
test runs before any DSS flag is read, so a malformed duplicate can no
longer mutate state retained from an earlier valid option. ADD_ADDR,
RM_ADDR, MP_PRIO and MP_FAIL stay permitted alongside DSS: once
mptcp_established_options_dss() has run, those are the only options
mptcp_established_options() can still add (:843-878).

Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:kimi-k3
Signed-off-by: Fourie Zhang <fouriezhang@tencent.com>
---
A KMSAN reproducer for this issue is available if requested.

 net/mptcp/options.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c664023d37ba..7ec18fa1bef6 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -153,6 +153,13 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_DSS:
+		/* Can be used with a restricted number of other options */
+		if ((mp_opt->suboptions & ~(OPTION_MPTCP_ADD_ADDR |
+					    OPTION_MPTCP_RM_ADDR |
+					    OPTION_MPTCP_PRIO |
+					    OPTION_MPTCP_FAIL)) != 0)
+			break;
+
 		pr_debug("DSS\n");
 		ptr++;
 
-- 
2.43.7

