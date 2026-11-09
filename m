Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794188679;
	b=OaFhIZtttBdXCR+cBpFpxdCd60UzFBg1H8OyTlotwTVadAUHfwLxN9ZFDr04GXro3tsC
	 S/fGmIapo1v6MKeVTeQeaAJQsCjpYUXfTtJ8/+pBFqzNXEi/0u57nhYrho/bih4am0G2P
	 IAbvGQ//QBBRn+9c+2sFeUiP5Iqke546Br8awYxKSdDaZcYAh3khfxZZIzxUQhxhTRCT6
	 yjzYP2IwT7mgc5q4nGUq3lFg2JnteDR2pJtPBp1pMujFYZl3sp2ntnStToAYCXyC+Bmpe
	 ILuXrHnCCNHU2oPMBKHgVVEOj4V6U0VEFBXvelcGGm89whjf5n85wDfUx6Uw+z3LIVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794188679;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bKRDH/csWdBIzl+fZEfHW5bnC7W0jUjOjtkERiHwheQ=;
	b=ll2VpqkrWKicZkNF0PscIR9EdvpIJwfv+gMFTj2LgD1XhyQrtx7nnn3Yyc+5Q+bRH5/3
	 +lSnbMHZpErZLtEtbB5OqPfad/gpViHl8Djmo+YAPtpfo2vyXru9UOgKbNFF0MJ/sYlCO
	 vYuj+AnPTRuzvnhS4+1XvEIvn3an2KYv+hHimk+8IJ4roOB5Qwl0A8np3DWqx0CvbML2z
	 oXDe9Yvx0Dr6E1GiJZG6E1wcRU30WABu/P3PbeJnanHRdmYLzh+VC28wdYA8FMKo1DwnJ
	 +VGfy8aPjt4j/yORfSIovnQ9UcxQ4Z9DBOyEjM6dKmAYCsuJPfKwTPG9VglWH+WIQnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=uRAuvNr+;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE8B606A326
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 01:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FE8B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=uRAuvNr+
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so92519a12.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 17:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794188679; x=1794793479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bKRDH/csWdBIzl+fZEfHW5bnC7W0jUjOjtkERiHwheQ=;
        b=uRAuvNr+vQKwjMhhzCS58E8T4CdgvTIY7JFU8+OURgPGInckS0JpIktGFqg818dhEu
         5/r5g10FVUMJ/aiabG+G7+q/lVBrauTSrNqxwqK/fs/3aDqEw0waE3a8N5XohMEocblQ
         k1WJfZsF4l9ZLVaj6tOqUNXhbrKIbAlbBeosMn9G2mMgigKTXMzv6e+6xlbqBiCekfYr
         2YgDfUnJO0mysYBEuDRw0ZGlHKX7ZBrwQ4+fSr8+DY3YaoFgAV77ocojr2FInLT7oICm
         ZM5iqyFAiAbaB49MN3yg4/KvE60oYqi+0kCtfYwg18gK79bGfjxX/+fCDv11KA5BxTDl
         /AIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794188679; x=1794793479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bKRDH/csWdBIzl+fZEfHW5bnC7W0jUjOjtkERiHwheQ=;
        b=rk24Cnk661ynR3EkF1IQDg4hKEwLZPQNxeY3lj9+K/XhyVTuur90at3AaMwyBY2lBF
         f/D2Tu0w0K1TBUX1Xw7MImVhZG86e7HJ6wsT1Klz7apLSVYXgcDpyRsh56t+U9lTVB8Y
         cSa9CQyc9bLtWo8BpwJn3/WZv+0cM3SAxY9LrbZ5idlXjKOTsgXjvZ+SM5GrYqIGF5bQ
         wM2XGH4PgZI7bBMVLszWv0hCNTuNc6EDh2jZNK0N7U532IFoFBUhniSN1GfkuVcA8EgY
         mBOMR2pyCYfQjUwauYi75B272qMEXcr7FCkGwH0oHPcB89+J5vYukZrO8p6QB85SF3mQ
         WzPA==
X-Gm-Message-State: APuU4Z/cGyQbFTW/AoEVbSVbUNuL83GftB/dRUDrRfIgQmE3jmEiQvlg
	Kt5CwI3TE/B5NaVBu1y6XB49jEs7/crVUZxtUit4XCjZEUdOD4mCdk2WP8a9CKEKd7jp3VHZ5AZ
	tA0xWV50=
X-Gm-Gg: AYBFou2+w9VhudOsvq0HLPTf9McIZxM1eeVO9G99iMcuuGt8cmt+TedbHvpsZ+0bxp6
	Sm1yHr0n78ed87oyppA0FAw7D6dvrVRQk6qA3rilChBT1Nrfyac7CbfNOdpQh9Zkml5SpI54NGw
	dMIdvY6bTaD+z0gdGM3bAi1EuR9US90Bgo7RjBjN7MrDXFMzJzzGPxLaRfar1H16Mp+L5g2t5MS
	sU14G5v2VKpNlE5giXlHCvRi7sAf6Wd173pKdNycs0QnCUOj+eKOfoK2Kt4d28vtC8M5YzJPET8
	qdlndbLw9tPMqD66Ef9mXCZzcF3u39wRRVscsaXLnbbo+EQFVy0vOEACR+HPkflbzGSuYnB8Rbm
	YiGaOoesO/0USGLnUUO1dZJG+xAz367PSAPEX2bSmsEjv/cO0I+rVSX10yZbsnZ4YPUxiynn9Hw
	QIIdAIkAJ6TC5bVfqfrS+ZrklW5aeVXMVRzTamkwzWxZiMOKsNy3t5oy1G+/SRO7gAFCLtoZ4gc
	8na8IKW8JtY7B2XDuId+IRkpdSXWPtuMfP57oFs1mFd+JOB5IgN9yBmRmI8c6R6qqGFbpfQpA8k
	BalqwCj3zjl/nhfpUVeIjL/Sd0JViOuY9OKSnhhYUcLWtZsEdM+ttOG39j7L01x2cTG590Q=
X-Received: by 2002:a17:90b:5683:b0:3b0:d551:ab2 with SMTP id 98e67ed59e1d1-3b12d5ac42fmr2381037a91.51.1794188678581;
        Sun, 08 Nov 2026 17:44:38 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0fc1bc1e6sm5641735a91.0.2026.11.08.17.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 17:44:37 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH iproute2 1/5] netlink: use a counter for sequence numbers
Date: Sun,  8 Nov 2026 17:43:58 -0800
Message-ID: <20261109014434.115922-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109014434.115922-1-stephen@networkplumber.org>
References: <20261109014434.115922-1-stephen@networkplumber.org>
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

Seeding the sequence number from time() breaks with a 32-bit time_t
after 2038: time() returns -1, the first request gets sequence zero,
and the range check in __rtnl_talk_iov() underflows, leaving ip
blocked in recvmsg(). The seed adds nothing since replies are already
matched by port id.

Drop the seed so libnetlink starts at 1, make the range check
wrap-safe, and replace the per-message time() in the mnl helpers with
a counter that starts at 1 and skips zero.

Reported-by: Florian Fainelli <f.fainelli@gmail.com>
Reported-by: Anthropic OSS scanner (ANT-2026-E6IHJA62)
Reported-by: Anthropic OSS scanner (ANT-2026-1UC2GBCD)
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 include/mnl_utils.h |  1 +
 lib/libnetlink.c    |  4 +---
 lib/mnl_utils.c     | 13 +++++++++++--
 rdma/utils.c        |  2 +-
 4 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/mnl_utils.h b/include/mnl_utils.h
index 4df9e398..d809383c 100644
--- a/include/mnl_utils.h
+++ b/include/mnl_utils.h
@@ -25,6 +25,7 @@ int mnlu_gen_socket_sndrcv(struct mnlu_gen_socket *nlg, const struct nlmsghdr *n
 
 struct mnl_socket *mnlu_socket_open(int bus);
 int mnl_add_nl_group(struct mnl_socket *nl, unsigned int group);
+uint32_t mnlu_next_seq(void);
 struct nlmsghdr *mnlu_msg_prepare(void *buf, uint32_t nlmsg_type, uint16_t flags,
 				  void *extra_header, size_t extra_header_size);
 int mnlu_socket_recv_run(struct mnl_socket *nl, unsigned int seq, void *buf, size_t buf_size,
diff --git a/lib/libnetlink.c b/lib/libnetlink.c
index edf3a8ba..6ff9cace 100644
--- a/lib/libnetlink.c
+++ b/lib/libnetlink.c
@@ -15,7 +15,6 @@
 #include <netinet/in.h>
 #include <string.h>
 #include <errno.h>
-#include <time.h>
 #include <sys/uio.h>
 #include <linux/fib_rules.h>
 #include <linux/if_addrlabel.h>
@@ -246,7 +245,6 @@ int rtnl_open_byproto(struct rtnl_handle *rth, unsigned int subscriptions,
 			rth->local.nl_family);
 		goto err;
 	}
-	rth->seq = time(NULL);
 	return 0;
 err:
 	rtnl_close(rth);
@@ -1092,7 +1090,7 @@ next:
 
 			if (nladdr.nl_pid != 0 ||
 			    h->nlmsg_pid != rtnl->local.nl_pid ||
-			    h->nlmsg_seq > seq || h->nlmsg_seq < seq - iovlen) {
+			    (unsigned int)(seq - h->nlmsg_seq) >= iovlen) {
 				/* Don't forget to skip that message. */
 				status -= NLMSG_ALIGN(len);
 				h = (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));
diff --git a/lib/mnl_utils.c b/lib/mnl_utils.c
index 43b4cd1a..44e54aa8 100644
--- a/lib/mnl_utils.c
+++ b/lib/mnl_utils.c
@@ -5,7 +5,6 @@
 
 #include <errno.h>
 #include <string.h>
-#include <time.h>
 #include <libmnl/libmnl.h>
 #include <linux/genetlink.h>
 
@@ -40,6 +39,16 @@ int mnl_add_nl_group(struct mnl_socket *nl, unsigned int group)
 	return mnl_socket_bind(nl, group, MNL_SOCKET_AUTOPID);
 }
 
+/* Sequence number for next request, zero is reserved for kernel events */
+uint32_t mnlu_next_seq(void)
+{
+	static uint32_t seq;
+
+	if (++seq == 0)
+		seq = 1;
+	return seq;
+}
+
 struct nlmsghdr *mnlu_msg_prepare(void *buf, uint32_t nlmsg_type, uint16_t flags,
 				  void *extra_header, size_t extra_header_size)
 {
@@ -49,7 +58,7 @@ struct nlmsghdr *mnlu_msg_prepare(void *buf, uint32_t nlmsg_type, uint16_t flags
 	nlh = mnl_nlmsg_put_header(buf);
 	nlh->nlmsg_type = nlmsg_type;
 	nlh->nlmsg_flags = flags;
-	nlh->nlmsg_seq = time(NULL);
+	nlh->nlmsg_seq = mnlu_next_seq();
 
 	eh = mnl_nlmsg_put_extra_header(nlh, extra_header_size);
 	memcpy(eh, extra_header, extra_header_size);
diff --git a/rdma/utils.c b/rdma/utils.c
index f6605eef..a85e8422 100644
--- a/rdma/utils.c
+++ b/rdma/utils.c
@@ -685,7 +685,7 @@ int rd_exec_cmd(struct rd *rd, const struct rd_cmd *cmds, const char *str)
 
 void rd_prepare_msg(struct rd *rd, uint32_t cmd, uint32_t *seq, uint16_t flags)
 {
-	*seq = time(NULL);
+	*seq = mnlu_next_seq();
 
 	rd->nlh = mnl_nlmsg_put_header(rd->buff);
 	rd->nlh->nlmsg_type = RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, cmd);
-- 
2.53.0

