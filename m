Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2AA3C9EC2
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255000; cv=none; b=tIFS8zpywu91Nw2Xynw3KrK6KpoYifCzb0n8n8db8izi4j8dqUrUTXXfWgnxchLnAsx4+HTY7HST7rhsNtPmm2eze9Sg+Y9Gr34pQOWtxmHfwUf+kfefCCvlsTopMW5okYQHy3VzpCs67MP/q1+DTPcb7Y2WrJGzNz5n0O9F9Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255000; c=relaxed/simple;
	bh=iWLgtboLR6eeifTFbpbNZJsQSIo8hfAjxNxNyjdyod4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2rd9KlM4OCzHNx6E6qWR+ezCpNwvG2C9sM9eOGJL6uFKbCJYvpWicCGwN4k9GZmKASnSfeHuNjAx6GejKKfmwkEUz0TTD09QxQnsmat1ThyIi2RNjd125tKhhK0opwuymb1IbIvg3zmN3ftcNgET/FzsUuK5j2uOaIG/dOIzDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=oKTmZtr0; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="oKTmZtr0"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8485ef63b68so4164819b3a.1
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 09:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1785254998; x=1785859798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vzLDqf3qkwmQV9Ac/krT+sjK+vy4k3H4FUkJylvYXqc=;
        b=oKTmZtr09dhmp41pgfxf4oEI8K1H+hq0qJ6h4k9yvfrNj62OlgQ8rc6F2qIlOxEpiP
         yS3uWJf4bBKC5/6nY7F8TAVdn4hGFgETN33qf50MQA8PzO3AF606A4/UKphq855uaDQp
         OLiGBWzx3GHnaBR2/gO/YORbXpk35NZt+zsyaNIMHZ+G3kENPxPS2k5VN425xIQmH+w8
         b5rkSz0QZOQN9JAteYaWx4O9fWfgBDpdQUWFx/C+R2ABwkgal2vQ1dDmXGMa79RrtWQh
         0sMM46nCQ4tKG/CIlj/xyQVEwJH0DgqCUos3Fx+CPPBk28vOqSNoXui0QuhO2b2nkYsV
         b5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785254998; x=1785859798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vzLDqf3qkwmQV9Ac/krT+sjK+vy4k3H4FUkJylvYXqc=;
        b=B2T4Q/2TJFS6MunMiV678iVkAjumRHI6n2vAR3AQUS3dNLbNB0DoXcf6UD406GQaAw
         OiKAGoe+E2hp6ISKzyCa99lTDifge1IK9LyDIGA08ZTaS7KI6Hjr9gtnmCY688vyJIv+
         cu1tqcCsXnwqbjw5o50Z62g36snZ46EXwtvsMg2CdAmOfUfOPrau/YRKat8Ib3/DsUXq
         EfyS0aZYggwcWRwmfh6NJmqCLoqXlmutVsYmwv06f7QeFLqaQdD/uL6PlFZlo6w5tD/d
         htOmZzIYp+hCfkdQLDnl/oEM2LVaYFnTNAa1vPMzaVAvi8AYF88ZMCnuOoOFP8Z4ALYU
         RlCw==
X-Gm-Message-State: AOJu0YzRkJmtjhONpYXfrKmtoh3jN/xD3pt/jICnBHRS4SdXwQNznhOx
	B3q6almnRwo8EAsAXkH91OOtBuKotzJku5GtYaWEywv4bKgqTjd8dHHJvDgePp8woHrWAwgbEBf
	JfUx1Lsut5fyC
X-Gm-Gg: AR+sD115C8WmSZGgC6kEOy9SjEtF4pG4cENsl18S7bmTwahRMryT0dPCJEU8mErKnlT
	zU9V+aUHiOIzNScXQrLd1tsdriOx4WtKrFcnLaXAhrSWakhfEnfB9IWpD4HGLMO8Xapuxv4wYP3
	pUQTckxG3m1ZkAPPVz21LdaHr6mp++FsEGdLtG8QrIOjlEzb5dRCm72yskGdTr/+kpMGbQ9/SMG
	Us0yax6cS539xHE24BFXOjoza4QhuCwg57XudmHQb84/u34VJS3TFCqeYU0xZEMoivHQA/XYk54
	lkAV5HDGt2bjos20WItW0nGFKk2hOVb+CqsaJtzgre3ebzyA0Co+i/h8DNGR74323NmZF8UWLnT
	HqsVqViNesyonNdq2DrU9Sh6sGFmRmOh9cMqTwj7okhKftsVZOU6dH03q2F0=
X-Received: by 2002:a05:6a00:234a:b0:848:2f6e:e52d with SMTP id d2e1a72fcca58-84e9337e95fmr3283360b3a.65.1785254998467;
        Tue, 28 Jul 2026 09:09:58 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:56::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea03767bbsm151521b3a.47.2026.07.28.09.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 09:09:57 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: andrew+netdev@lunn.ch,
	willemb@google.com,
	linux-kselftest@vger.kernel.org,
	Joe Damato <joe@dama.to>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/5] selftests/net: psock: Generalize stats check
Date: Tue, 28 Jul 2026 09:09:27 -0700
Message-ID: <20260728160935.4128982-3-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728160935.4128982-1-joe@dama.to>
References: <20260728160935.4128982-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generalize stats check code so that callers can specify the expected
packets.

Signed-off-by: Joe Damato <joe@dama.to>
---
 tools/testing/selftests/net/psock_snd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/psock_snd.c b/tools/testing/selftests/net/psock_snd.c
index bb9a9cfdbe95..d506ea19491b 100644
--- a/tools/testing/selftests/net/psock_snd.c
+++ b/tools/testing/selftests/net/psock_snd.c
@@ -440,7 +440,7 @@ static void parse_opts(int argc, char **argv)
 		error(1, 0, "option aux data (-a) conflicts with drop (-D)");
 }
 
-static void check_packet_stats(int fd)
+static void check_packet_stats(int fd, unsigned int expected_packets)
 {
 	struct tpacket_stats st = {};
 	socklen_t len = sizeof(st);
@@ -459,8 +459,9 @@ static void check_packet_stats(int fd)
 		if (st.tp_drops == 0)
 			error(1, 0, "stats: expected drops but tp_drops == 0");
 	} else {
-		if (st.tp_packets != 1)
-			error(1, 0, "stats: tp_packets %u != 1", st.tp_packets);
+		if (st.tp_packets != expected_packets)
+			error(1, 0, "stats: tp_packets %u != %u",
+			      st.tp_packets, expected_packets);
 
 		if (st.tp_drops != 0)
 			error(1, 0, "stats: tp_drops %u != 0", st.tp_drops);
@@ -490,7 +491,7 @@ static void run_test(void)
 	total_len = do_tx();
 
 	if (cfg_drop) {
-		check_packet_stats(fds);
+		check_packet_stats(fds, 0);
 		goto out;
 	}
 
@@ -498,7 +499,7 @@ static void run_test(void)
 	if (cfg_payload_len == DATA_LEN && !cfg_use_vlan) {
 		do_rx(fds, total_len - sizeof(struct virtio_net_hdr),
 		      tbuf + sizeof(struct virtio_net_hdr), true);
-		check_packet_stats(fds);
+		check_packet_stats(fds, 1);
 	}
 
 	do_rx(fdr, cfg_payload_len, tbuf + total_len - cfg_payload_len, false);
-- 
2.53.0-Meta

