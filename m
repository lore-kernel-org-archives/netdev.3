Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010C24F3EB4
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677839; cv=none; b=GY7HhgrsH0umUcLTdOQ7HOFMYZabthxaU23KDRl+CkwI/M0uHp1suDpEcd6TXhwWf6ynsrm3d4586qkHC5NcpAGTNmKu/KrHf64mrrxtctJpdJzUoG+GvmaNL/J1R38jdPpCCDPTu31s61TZ3no/35VbP6moRQs52ij7FyAd90w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677839; c=relaxed/simple;
	bh=3sf9YuBAZ2zv9t1g2dgGBjeM9ZfIN0Yd/tz3mo8MbxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TI6fqLMH+wFekUDFQL6flq0vtOJLCn0J+jNIN6Fkw2TlKuAMtLOdLPcFMh9K5qc5bNbtAvR0SE68JIuv6c+R/MByA0V0EuFwjWdKBFNQYUZSO3h2oQOWTnRR/1EsvlY/MlfMjinKGPhCB6LZpScpZGKDn5TtzhAX9+C+JH3iDZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ryFXBWcT; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryFXBWcT"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d91ede8035so631365ad.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789677829; x=1790282629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ia2nV/eyt+q8ysG7SMAINIwAk3HmajymljLtHeWJQM=;
        b=ryFXBWcTYawFB3BGv/pfWTAIDdTh29wQg6jfqCyPuJV0AVPE754oH8c5KPuT2lcB2u
         WvDdv0z11q4lrB9Ul0zcyv6HzN0cMrGVOY+R48cUvjatKoAZhHtJOA3lDpRBZrTjer3W
         ZgimzYwE9sEZw07NDOq/NkrnN/s/Vbb/9zOmHfllM8/JqklzbYog+cDrKhEqbcmZXumX
         fjwn+aNMNiN8vBEBfU5zP0UX+Uv81A8XA+onB6AHk/DFhlUiuGfWWJmwRQUCilZBFl02
         6LLfxI0FMgrGoc0pcJ3FL/i2hDprFh3DIXwBRwbegVujtTWym8/kltGrIthkFl28bVqt
         q7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789677829; x=1790282629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9ia2nV/eyt+q8ysG7SMAINIwAk3HmajymljLtHeWJQM=;
        b=vyenYRzmvH6pVFfO0fLtNRWl1VYu/ABNr0oJc1K5BkzGhFt7J6kBK/T/69+qSeL7yK
         GwCcPMU8G8jpB9wLgAk9T5OxuhuOuZTQVJDxo1wCDwqdkT5IszKXIC/VfUQh2W7UwTHE
         UHuTLpSVYSjJOVvhY0BQGVDp5zIVX3i3li4IwWOmf0ovh5qcq7EiIemJIGS/WuhcAsig
         h6Cwx8UMeEVaDkInN30pvXeCp76KlcZeNad2RIGi1OJCoKuIL/gqHmnLMx4XDUAM2ujY
         eFWJYEbEOK3fqAvxhQ8z4MSVV4QS7lXKc6qJDPdBjhwPNWePfXtakqKSnVgruUMoweYB
         6y9g==
X-Gm-Message-State: AFuF++mmH2ITeVgKDjLoXwpd1HO4xsAb1sVr5UPEu7DzN1NnwH48vZeG
	pdJefbQlUoN+YGdU0dOOtPLVByU0FSA3yhFdz12F1AEW5dy5sdJ17sGcU344ea+g
X-Gm-Gg: AYBFou0A/2PnvTyzt2p7XztrSSzUmaRr6YuJki5lCvQBp0vCgFC5nCBG2V2i4YHupoe
	WGSTKXBNyEXe5V298YMc9t6A+azEFFCTO8cyjPTVWHeZP8XSeTkOEHyqjIFMbKPdxoAKNeJsbvF
	Q1+TshW9f9RnWFPhbS487mWK8jpdteFXgmtAdW7vEshOoSmfyi/SenpYUw3ymhfMJ9MzCQykZuq
	DIYmqiPpfEzrJASubot7Ny4ph7qLhrkLYGyz3hD7859NqUrRK9MZiLvhLw3G34M+Sb5g6QXu8eT
	le4LII332sYKw9d8Jq0D925JEcgSHel94uZMd3EAb6tIxdENOJhis9Cd84MXCkvYPA1O8dXgARg
	2cQ3jal5ubhyJwQJ92gRcDiD9Fb01Zw2Vjk4G1MtxPBZPGWhyZUc2PaRS16DlDuJfhZEZyvSJn4
	TibhoMQmdToFwBXnDeClFymcQDG3DPWBUMFoANOGItDEC7jeSrx61pAqAAUAz81dvqCIWC6lhOR
	TiR7gz3U4wHlqzPICLxdTPG/FdVUEsm50M991d3QgBq9vB643VoKEfVtnDdjct7JtXzdM/KbfQ=
X-Received: by 2002:a17:903:2312:b0:2cc:6018:f030 with SMTP id d9443c01a7336-2ddb1b899famr7318915ad.14.1789677829118;
        Thu, 17 Sep 2026 13:43:49 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:6248:69c:ea81:be26])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c1943f4bcsm3620046eec.21.2026.09.17.13.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:43:48 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	jhs@mojatatu.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH net-next v6 3/3] net/sched: pie: correct tc_pie_xstats field documentation
Date: Fri, 18 Sep 2026 02:12:25 +0530
Message-Id: <20260917204225.275251-4-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917204225.275251-1-hemendranaik@gmail.com>
References: <20260917204225.275251-1-hemendranaik@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comments describing struct tc_pie_xstats do not match the values
exported by the kernel.

Update the delay field comment to microseconds (PSCHED_TICKS2NS() /
NSEC_PER_USEC). Update avg_dq_rate to bytes/second (avg_dq_rate *
PSCHED_TICKS_PER_SEC >> PIE_SCALE).

Documentation-only; no UAPI layout or runtime change. Touch
include/uapi/linux/pkt_sched.h only

Signed-off-by: Hemendra M. Naik <hemendranaik@gmail.com>
Signed-off-by: Vishal Kamath <vishy0777@gmail.com>
Signed-off-by: Mohit P. Tahiliani <tahiliani@nitk.edu.in>
---
 include/uapi/linux/pkt_sched.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 9c0c9787f0c3..969fa30efae7 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -920,9 +920,9 @@ enum {
 
 struct tc_pie_xstats {
 	__u64 prob;			/* current probability */
-	__u32 delay;			/* current delay in ms */
+	__u32 delay;			/* current delay in microseconds */
 	__u32 avg_dq_rate;		/* current average dq_rate in
-					 * bits/pie_time
+					 * bytes/second
 					 */
 	__u32 dq_rate_estimating;	/* is avg_dq_rate being calculated? */
 	__u32 packets_in;		/* total number of packets enqueued */
-- 
2.34.1

