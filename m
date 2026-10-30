Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793358667;
	b=GE0qVjzajDfjlsvgZzVhrYOXNL/P9na6yS7SvLRgpHa2nBEceNO3FwCssdBG0bnmWgCp
	 /i8P1XHz4AhWMe4/eW+FHy7KNVOhf9WI/UjjlxuiIQgNF0xlTejPHpnB94KTlszSjl7Hm
	 2zemWe+2FmBmpGkLJhu6mniplIDiuRF6MXZz+UKNiJU3W5exCH79XR5lt3s5yezUM7EB/
	 gMceb82o036im3SY7cGJrjsd0Vg10//zJ/t9fAWdKCKYG0N2pJ6W641oxXgBD5JCAz5gk
	 DbPtpK0+f1gw/USwftRCQcLWRiLgAgy+ZEoGpZQFYUWerEdCkuj2sPzFMUaA4+RtV0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358667;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=+WghCCVj/g7O1H6Bv64tZFo0L+kNuS7zgljqJhCtvfE=;
	b=aLKzA+de4j6mCqOeEc78x4S5XoeiyjU1QVEl+TuyrhNashSqmZclOsx3TNsFdAZ9p3xY
	 n+UMvQSCUe8B0vQ9oSZIjM4OT/eY+6+tuZjdaBXLVeaAkrDIrZDWZztR9EYxMEJs+7Cwo
	 wVxQa7YYhrslY5LAnoi2l2TqiauYtvXZgV7piIV25ln3rfpn2JbIINoAKIPOlJIaLt1SX
	 /EQswPh5j4r9e7Nf+L+3IVgsTXRH0JXyQEFEbnPU2dMW17VX2chfIJvcjcF8std7sQk8u
	 JkE/AODPNVU+I/GQLUMvks3I+/2u5a4I0YCs5cFtTTVdL+8TznsBvfA/GD54YNvTgLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jsZq87Nc;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B66606A325
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 11:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3B66606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jsZq87Nc
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-990835cec4bso416135241.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793358665; x=1793963465; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+WghCCVj/g7O1H6Bv64tZFo0L+kNuS7zgljqJhCtvfE=;
        b=jsZq87NcQfTZpaVK69QLYee3ckZ37vLXsRiXIosB9EJM2g0zFCXwWJAOd68DGuPHaS
         LfK3N3M1jYLIExY9JTp8RfnYngWVpuPMKV3hBIfQax9b43PrZHgYsbdbvZ7yjThJzVlv
         5F99iF1S2TCF/Qxgn9e3YVLL632hAD8Gv+2/RE6LJYyYiJ7S2Zi0cbRo9GsoquIquPJL
         aFEAv7dPVqJX8OwLQzfAMzHutxscUmMHHRzCqoaSRZN4fg+kD86oHe3oAYqJp1wuNKBY
         8zV5KFQmJ62hKDVeUtg7nPh6/xMPSOHf+JsfDb8CJBEuXbnn0Rt607qZxGeV9oqoTFRJ
         gSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793358665; x=1793963465;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+WghCCVj/g7O1H6Bv64tZFo0L+kNuS7zgljqJhCtvfE=;
        b=i3Y2W8Gq0/mclWjQZDlm4gSkNxzBwWgAwCL7RvJ2tLnj33GWtKkyjC0z3ch0t0xe00
         NHVjK+FK1B4M/Q7jYD9H5i2jVvKZB1buBOGSrECfnfKwZyApZroLhTufeeORi17aNVOt
         pWm/cvY8uCKCrcT+0ZKVgH/SwfjDdiaxIaikqxJ2AUMOZrl1TWUaYAVKClgqolwwIJ+V
         1ZJvEg6z05pwJPyQE8rFnA4sPK7zLoZYlgMcFCMoz3bnEZA1Syfqh9za56UVvZIsvGQB
         J+lG8+p4u9WbV4PhjMc7LaT1100HSmvw7EEJPq0Lxd4FaoVf3U+Ot2J866mTIFlcw7Yd
         cuvQ==
X-Forwarded-Encrypted: i=1; AKwUvBxNUg4KrvHiDY/H6rrYjqWnYGYbMH0GDFNjqHPmcb4OeQDM1CGS3BPRqFDvLMPKESviQYZwoM8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKowJiqbqlEdYhG4JRhSowoz3QM84KeKUMYkb1ku7YlWLAlz7ME
	7EhJnbY6SNBYbqnw6o1MKNbAKKvTTp84tBEN5Y0Y329ZLLuheDeVZlDd
X-Gm-Gg: AYBFou2b6AZYNVzvyjo7JV53dqz1Yb6NHJvWmOfd/DvPfjmbu0e9a4LPSV3g1D7Xsuj
	FOCE2iAsyH5w6jKRLcbpL9hMlktQyqHWRi4KcHrsTtWk2q6gBzPH3uLypW8wJF66Huk2SCX/4KE
	WirIcIeFveKMbKGgABdM8zZyaSKoEZSH40aq05Y/fVFNrdditSyJZjhvfSs+Vx+H7B/1ET90UjM
	RjUb5ufTkTP329q6OivrjzDTrqfzRf/rYOeak1pXuzvX3MJSG9FfxOGhO4EwCMZZbWGzAI3jTuN
	/yFWvdYFMTRkOXTI8frjPDOVQYIYENBTx98myV7wgWD1jH2+a2vqd7uxQWOLxjNMIIWphkas5GO
	J6ZwRGzHOLU9MTxqkGcb+m6uruJGiosbFnCE2p87UTrctyAeAIS7Ul2ja1ugPl7VIt626d3wD5S
	3aczaHQGcpsiySGoLD6DuRy2crRjlpPEYCWzf1z5L5zCkVt9ccKKK8z7EeXTqlzuKIRTSO6sNBu
	wiAb60kLVK6rUK7NOpSLWRv0+jyV964V+YcLz4lPQ9ozEmcDa2OMYHoOIuDdsBYBCNqFa8McJvv
	rb+vrFp/4sZLmR8rn8Rh6ReMD7yy/UAjCGtGEcBYTyJm07N1agHn5kYhbLIZ0Q5R6ZpyfYQC+zr
	Nn/5NfdQzVhgqsyC1sNAwtofCyAdwysC/1/nSeNoM
X-Received: by 2002:a05:6102:2b85:b0:79e:373e:8216 with SMTP id ada2fe7eead31-7d0723d2480mr1002923137.0.1793358665428;
        Fri, 30 Oct 2026 04:11:05 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([191.34.116.20])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d07754c1b4sm1841044137.4.2026.10.30.04.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:11:05 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 2/3] nfc: rawsock: free the response skb when the data
 exchange fails
Date: Fri, 30 Oct 2026 08:10:42 -0300
Message-ID: <179335864272.64596.4931238314416806197@gmail.com>
In-Reply-To: <179335864271.64596.805818095553030218@gmail.com>
References: <179335864271.64596.805818095553030218@gmail.com>
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

rawsock_data_exchange_complete() only frees the skb it is given when
the exchange succeeded.  But the skb can carry the response even when
err is set: the HCI core passes it on with the error derived from the
controller's result code (__nfc_hci_cmd_completion() gives it to the
callback and does not free it, and hci_transceive_cb() and the pn544,
st21nfca and microread data exchange callbacks forward it as is), and
NCI does the same for a frame interface data packet with a non-zero
status byte.  So each failed exchange on a raw socket leaks an skb, and
a controller or tag that keeps failing exchanges leaks memory without
bound.

This was found by LLM-assisted code review.

Free the skb on the error path too; it is NULL when the error does not
come with a response (digital, timeouts, device close), and
kfree_skb() handles that.

Fixes: 23b7869c0fd0 ("NFC: add the NFC socket raw protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Yaga Agent HackerSec Claude:claude-opus-5-5
---
 net/nfc/rawsock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/nfc/rawsock.c b/net/nfc/rawsock.c
index f7d7a599f..74ef3906c 100644
--- a/net/nfc/rawsock.c
+++ b/net/nfc/rawsock.c
@@ -156,8 +156,9 @@ static void rawsock_data_exchange_complete(void *context, struct sk_buff *skb,
 
 	pr_debug("sk=%p err=%d\n", sk, err);
 
+	/* skb may carry the response even when the exchange failed */
 	if (err)
-		goto error;
+		goto error_skb;
 
 	err = rawsock_add_header(skb);
 	if (err)
@@ -180,7 +181,6 @@ static void rawsock_data_exchange_complete(void *context, struct sk_buff *skb,
 error_skb:
 	kfree_skb(skb);
 
-error:
 	rawsock_report_error(sk, err);
 	sock_put(sk);
 }
-- 
2.43.0

