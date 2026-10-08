Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0834E36D7
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 15:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473338; cv=none; b=qcoXBG+WYiRIZQfMowPzbyiHIupAbQGpKgZJH2ibGvZ8anAmEIcD3FL73imXwEHZJgfum6sDmOgWRXHTLxXTxTluTYGf3FfZTTvRgVF1eG7BTZYJSL1T7SOAMBguugCHjsyTtHBfqfzCnR2XSExSt9B98WmXfoMR6WSqq93AyfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473338; c=relaxed/simple;
	bh=9IArv5E0HDoDgrm+EOLj8lDAwLd2ErbcWCrSvCceLBw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SZQJh/kft4fnQzmiUK2PRiEBfMfsj9UE4RHlHsrfS4kznA8oT49id2hSO7hp/ixDf3SivU6qG+LxZ2nzesqKtw3u7V9CRMwzPFT/9BxCNwsry+e8L85gJspiIhl6MuEN+A/X3Vjw/j4ntPI/0wCZoqSyIo1h4VmE/C2ti3RYZnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfXIMqsN; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfXIMqsN"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-823545ce223so4533704a34.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 08:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791473326; x=1792078126; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oQ/GaoOi8qfcW0im1RCBWVWH2WffDR373jza/mtw0gw=;
        b=NfXIMqsNGbw+vfpL75dXTzLc7fqvSAbsJjc0ESuyn/LJ7Vne/+1t85oReQgCzVV7tK
         L4Ji2k4CgmqzXdu5jFxVkLWY9Ujb3HpCjAUhbLnvZ6NBm8egTetndOMzAyqyF0WFVlCI
         Jyx/zMCaI4ahhDdVIwotYc1kCXMdH7SGwuUvJVlanRz0+eRDBjpwF/uoV/P7DxCua1jS
         s9m/SvkWMrus27hfoe2rcX/gYPNYQ8AaLpcySURnayhUSnvG0ecq3ToaVdzVPN4ZoJn2
         +cjMa99sDICTA8NF4tpOSYJvY+NqpcTc+be2yLq97VwXvy3L9+7V123p9iof+C6ykb0Y
         LX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791473326; x=1792078126;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oQ/GaoOi8qfcW0im1RCBWVWH2WffDR373jza/mtw0gw=;
        b=yg1MoSzzoKzTXSsWnafWkU7sVn7+4ZFcMUN1KRXOATYiQ6WtNrdSaWeso8DlC8fqfS
         kGxjIuJA0pjludFj3W5XVCJHBiXMk2CDPnhsz1/E5drWOC+5hjB8paokrzbXCOfK1YNe
         NFSMvnVq2RteHdXltDqmU4OAFyGJWwqDJYP2Racn85PfRXw6wlhvVY7SEH/bmEUTYFeq
         1l804HiK9bDmwP7QX2e7edYaUt48LigSz6/IwJxX1m+zmcHYAEGIvysM9d4X2bE5BRHX
         i6xhBA670GOnEp4umkcMn2P/F4bGx1MGJ5j3Gwq7XcIW6GpQ5E0D6oqC6YFXPZCN5DId
         nISA==
X-Forwarded-Encrypted: i=1; AKwUvBzoxh2kGLvVyZNIvypYLSzZHGAlepsI79fXtsDQvISnbUi7RwHmikP3tafkVohWsYa4k5pfkbA=@vger.kernel.org
X-Gm-Message-State: AFuF++mLYW0WGYUeOvdr57iW9NUwlJFgTqlnjdMp8aaW8NrFFWN+e9W0
	wuesSFO9dbiD2QW4hKkvLDo4mITRAOwGDr7VBb3S1QTUvt84UgkotCN1
X-Gm-Gg: AYBFou0rf61q+cZQjVA6KALbP5rUGwrOyBG0wWvFJa+T4UQcL6cxWgHFiRtzDJIDz16
	GCuV7/AHRPzh8HQ+BhsZeMwTW+RYZd8KV84cFpMxSv9spRhHCfCVtte2BjfBHoe86qE4FRrlAKO
	B4qgAB8C9AowbSnOJBo8Qf9zGa9Q8YsCGPsDU2z384wEe9rFTeE5PbyLCGKT6XmGOEehazt2npm
	S9Z4XcvV/lM30iuKW0JaDmelbZO0odL3poNb82mhjXnOMTJeJt2vcVbX5QluT343MwnRjeH7qnO
	roUMof6i1JqDSV2YVle1W5svJOo4nDGVg4a6XwAo4TXBGJPUBcj37KjiqYdNjVdWz7izeW8VwGf
	QN7GimpzbxaqPS2BmZmvIr9CyzenVOCe5/XKMZOlaQxLgvLkkQKzwGS5ORycTM1YoHBKmdJScc6
	3rjnSrlx7vHO1b2oC1HhEjY7wKqziHbyl028ktdWKD0pelsCXixZnpzPiGl9F7RjwgrLjQd7wP8
	tHC/A/XrjrwLJy5A+++tqEtm31/oaQeyyMdjmd96xECZgq6JbCQR/5CcLPil+KlzCL6+5gL2+It
	oPXrELO6AQ+mx2CYBX8Q0SZyBI7ycq3AT4uEWzbmuG+jY64tOc85ugSvI5rVrw==
X-Received: by 2002:a05:6830:349e:b0:800:d883:9988 with SMTP id 46e09a7af769-82ac9d8f975mr7498436a34.0.1791473326271;
        Thu, 08 Oct 2026 08:28:46 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2804:7f0:b100:655c:c517:c6a0:13b2:a6e1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82adcd0f5d7sm5853429a34.27.2026.10.08.08.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:28:45 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org
Subject: [PATCH nf-next v2] netfilter: nf_conntrack_sip: only honour Via: port
 in original direction
Date: Thu, 08 Oct 2026 12:28:37 -0300
Message-ID: <179147331732.58100.8577886696698663796@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

The Cisco phone workaround in process_sip_request() records the port
from the topmost Via: header in ct_sip_info->forced_dport whenever the
Via address matches the sender of the current request and the port
differs from the sender's source port.  nf_nat_sip() then rewrites the
UDP destination port of every reply-direction packet to that value.

The workaround is meant for phones behind the NAT, i.e. requests in the
original direction, but the check is done in both directions.  For a
request arriving in the reply direction, ct->tuplehash[dir].tuple.src
is the remote peer itself, so the peer meets the condition with a Via:
line carrying its own address and any port >= 1024.  From then on its
datagrams on that flow are delivered to the NATed host on the port it
chose rather than the mapped one.  No spoofing is needed, but the peer
has to be the SIP server or proxy the client talks to, and the effect
is limited to that flow.

Only honour the Via: port for requests in the original direction.

Found by manual inspection of nf_conntrack_sip.c and nf_nat_sip.c,
assisted by an LLM, and confirmed at runtime with client, router and
server network namespaces (nft masquerade plus a "sip" ct helper on the
router): the server's request and a following UDP payload reached the
client on the Via: port before this change, and the mapped port after.

Fixes: 7266507d8999 ("netfilter: nf_ct_sip: support Cisco 7941/7945 IP phones")
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Claude:claude-opus-5-5
---
Changes in v2:
- Retarget to nf-next as a correctness fix (Pablo).
- Describe the precondition (rogue SIP peer, no spoofing) and how the
  issue was found in the commit message.

 net/netfilter/nf_conntrack_sip.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index 64bc440b1..ef655a0bb 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -1586,8 +1586,14 @@ static int process_sip_request(struct sk_buff *skb, unsigned int protoff,
 	 * router for one of these phones, save the port number from the
 	 * Via: header so that nf_nat_sip can redirect the responses to
 	 * the correct port.
+	 *
+	 * Only honour the Via: port for requests coming from the phone,
+	 * i.e. in the original direction.  The remote peer must not be
+	 * able to pick the destination port of packets delivered to the
+	 * NATed host.
 	 */
-	if (ct_sip_parse_header_uri(ct, *dptr, NULL, *datalen,
+	if (dir == IP_CT_DIR_ORIGINAL &&
+	    ct_sip_parse_header_uri(ct, *dptr, NULL, *datalen,
 				    SIP_HDR_VIA_UDP, NULL, &matchoff,
 				    &matchlen, &addr, &port) > 0 &&
 	    port != ct->tuplehash[dir].tuple.src.u.udp.port &&
