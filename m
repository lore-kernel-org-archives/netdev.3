Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792638585;
	b=lyFCW6j5IuF4E+qs7NjHpppzXMcniVBLO3fzWZAVjV7I0LfcE0gLqOeS9VVa/oFLqsBQ
	 KWJhYclGabvO6OvvE0iVvpVOkQBIek/0kK68KE7YkRg4cHN5Fp179PXfY5JfGckVEkLKa
	 jrWIJRrB6O2gxkTFsFUuHqNqxjKBV3I2UJEp/7wN14O2567XrhM51O9hGIomikZEv6dEi
	 alnvgTWiE6gEsyicPVmgUYCsDMyCqb6CY1wImGHuebqNSR61I+TM7t2JcWGQ4PGsspuR4
	 SxSqEAhhxbOa3D/JqYPz5VDZOPT9OpIeJnRI14WAsYUO0qF2tUXOUoTWD9CO95HY7bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792638585;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=MUJZAYrAzAHox5NbWunOTBXkvjjHAyJ/e+1fwM5DNtI=;
	b=DTAG6RXlfrteCiXr2R2aD5eIBEGmDUbjuAZZmk7jUVNuchmIpcPvWqy7auaXXhq5O1+q
	 5TnnmPsPyIFj32yN1IG3IU3CjwLr9d6IicCNeAdHn+cIsbZFdhkikFdi8+a48IWL3F8th
	 te8taIx2HO7NzPLCNO4ZeKD/exQ92Ve0lVeo9maISrAILFM3JyYkarPdwKIbwOQt49bEa
	 qoZp3O6BpskaqBWRVOW4XgXDG1rMN6FSwGldeWGPwOX2BuRJrKWfLmVIk1aFDw9Uuh1wO
	 iz9xuyC76gh2gVzntc5ADGKLW9DTe56UItSr1iiaT7sm7eit+ofmhEmT3hVcbdhdlHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DGmL0Cvv;
	arc=none smtp.remote-ip=95.215.58.197
Received: from mta1.migadu.com (out-197.mta1.migadu.com [95.215.58.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6471606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 03:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6471606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DGmL0Cvv
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Ix6esvmcmYVkZDYk3pa2wudzAplpDNzwTlH4FWpONAw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792638582; v=1; x=1793243382;
 b=DGmL0CvvS3Xj+xHTQWrWmACkPQ01Fv5o7HfwuLmikomZpUKML0eV8gFjUCeu3JUNTNvI6UM6
 IuNRSHnoSRAas812/CyOU4G82RyfEtJqKNnRRe7qAYhH+GNbBXk11k52qx9Jzns+Qv8eDTWrEZp
 BtYlyxbE/gH1n3MzBwll/zH0=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 8ac16d0dcb93197d;
	Thu, 22 Oct 2026 03:09:41 +0000
X-Mizu-Trace-ID: 8ac16d0dcb93197d
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Thu, 22 Oct 2026 11:09:35 +0800
Subject: [PATCH net] selftests: gro: remove unused variable total_data
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
Message-Id: <20261022-self_unused_var-v1-1-8ab10a6b7f44@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBQFr1Le2kATbBCvIlJi86JfJEp+U4TSu
 xt1OQMzK5RFqDh2KwoXUXnmBnbXYbqFfKWR2Biud972zhnlI401V2Ucl1BMHPYhHaK3YfBo1as
 wyft3PCFzxvkvtV7unObvC9v2AVngXid4AAAA
X-Change-ID: 20261022-self_unused_var-d54af8d61a56
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.16.0

From: Hangbin Liu <liuhangbin@kylinos.cn>

I hit a build warning when building the net selftests.

  gro.c: In function 'check_capacity_pkts':                                                                                                                                                                                     gro.c:1249:13: warning: variable 'total_data' set but not used [-Wunused-but-set-variable=]
   1249 |         int total_data = 0;
        |             ^~~~~~~~~~

Remove the total_data variable, as it is no longer used.

Fixes: d97348474708 ("selftests: drv-net: gro: always wait for FIN in the capacity test")
Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 tools/testing/selftests/net/lib/gro.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/gro.c b/tools/testing/selftests/net/lib/gro.c
index 7a333155de1a..1bc92e7a625f 100644
--- a/tools/testing/selftests/net/lib/gro.c
+++ b/tools/testing/selftests/net/lib/gro.c
@@ -1246,7 +1246,6 @@ static void check_capacity_pkts(int fd)
 	int coalesced[num_flows];
 	struct tcphdr *tcph;
 	int ip_ext_len = 0;
-	int total_data = 0;
 	int pkt_size = -1;
 	int data_len = 0;
 	int flow_id;
@@ -1309,7 +1308,6 @@ static void check_capacity_pkts(int fd)
 		}
 
 		num_pkt++;
-		total_data += data_len;
 	}
 
 	/* Check flow ordering. We expect to see all non-coalesced first segs

---
base-commit: e0a958ddfc89f2e1c43448cdaeb5b30e54e19448
change-id: 20261022-self_unused_var-d54af8d61a56

Best regards,
--  
Hangbin Liu <liuhangbin@kylinos.cn>

