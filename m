Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F65536F912
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 22:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786400195; cv=none; b=tRgH2nHHpPxn/UB++ivEmad5YXBcbS+7GiOLn5DNLrwXK1Fii2hcPLy6KCkOXSxSCPul3EUSmVUyEcpNNt7B1UdtMuv5ncQPvtojD2TQKThITIxPv1/x6Ix8qrZd1Yow4d0atvEnrGquCVUZqNGk4O+amuQOFbuQz3jWyzg3JyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786400195; c=relaxed/simple;
	bh=uYxhiZqGm8FNfk3nEbeKBpAuZF64uazG6DvZD8QGX/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gA0JCEY7fYJwQ0pvoFViYz2LgEx4rt7LnouZuZd45FVhwdIDMNZ6IEID1Nds6CnI/n6073IiKkJdT9RNXqIlRp4HY2YrHhD7g+AG0lB3rI/DAnSbMGdg6+dwE+JNA4KBgD352Cjkwax5Ill/AgbkAsVNGgG3R3izQr4V90HyOkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=bcQNgfwm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="bcQNgfwm"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cacb8416a1so24373265ad.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 15:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1786400193; x=1787004993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mT7jUmlNFDrp1iX8E1gn1RaOCxcycH+YHLaaoGQkKZc=;
        b=bcQNgfwmlpPpapt40RmbCEbsvsJ132cpQhA2jJIm7XAx0TcPor7fm8AC7FoiHqGxR5
         XRk+q3O95LCEDpU49LCOa8AaRIjms2pxXTUnuXETGD7rNf9ZMYZbg9MgAg356/HJOxck
         VWnWHaZFvk6gXgfWtgNgqtJmUoNyPk4XpgTBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786400193; x=1787004993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mT7jUmlNFDrp1iX8E1gn1RaOCxcycH+YHLaaoGQkKZc=;
        b=E4wHzJm9l6AjKM3K87VmQKhffucSkGRfIKi6yq3ZA9WwbB1GWYN0o6NhxqVgBwAsM6
         2Fsqy5PYOVqIpf/EAAPAb44pCUam1aG7yCVwm5PDzT5pwvwxxpn+9NHzdrcoWrWLeZ+A
         N1JwblF546sS7qofcanP55gs3AtvLi4X6aIQ8ksI4vPoRZXFeGhHrEBSaOGk9Iey2nhL
         9q1cNF+YlYyt5ri1/D9ZJpM8HENJ6YoFw8kbv5ue6y7+vIaZjpv7Lb6vfYq4aGlr+EOW
         co986p7rCOCXNLNe/mjKjIYGa8R0PA36Jx013DtzvQz/Q6eikg4NJu73/hIswa8Uh7sh
         T92g==
X-Forwarded-Encrypted: i=1; AHgh+RpCuOjsk8E2dORmye9t/OEiaW7sOCcZlueJ7L36bAbTe68Z6saJCIBLWyrubYqykainPMMGE+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9uMsOiKWdtc071Ni8c5Td6Dvd+uWGYoLo/i/DE1Ext5XifuWV
	lgbPvIeEB0RMEUSeT+TOoy+tHAfEG19NHtUCLGoeIFd3mc6gtS3Qjm4yrDPCUj00ok8=
X-Gm-Gg: AR+sD11lcn0tO+uPDYSjOSUf7UWsAqFDEUF5J8TsBLoT9kKOhAce7qdQcpFsuGXw7Ji
	STEUqJgeOsXy8yLwagLAyzVA9rHFi5Rgax20FjN5vh/5PI0xTaKIRiglGOCZGK2Ve7oISxgJFvy
	tvyAMw1D2XSU2PrIiiyFUuuvjI6JhTgIF/DBjIb+uhqr7eOs2HPNnlzDEkJ+CZbDQioQFUgaKay
	XJNXm9LCLWNtBwkwVD7McSW7JAN12+zRsWxIG86SgnktNmVeDmCj7KE/A1qKH/gYkdka2HMwHmQ
	82UxmabGcPuTRjiFlfYsXHNxC2QgZn6IMhT0lJt3zt2vueOgXQo3AFXOq3egDFkdkfEZCdKOCvJ
	ywBWD9xaMeoeisPed0unR4viVg0jI1UyfEFhnwT/xbDyOk6Dai26hba7SUkCb3TciS8+NndfLYl
	XWzapYxa7Xq5xOL0hK4k7XDwjTubGmZUFlz1oSJWzQhEnPkOH8socWHiykuYB7ZTzpFMf4ZugmW
	2JIqf+LvkP6FZ6b3WRu6nylbOq4HTsfW1CZxIB0IKXkugAQUF4OIgLSDqZRpz/+
X-Received: by 2002:a17:903:acc:b0:2cf:b68a:340 with SMTP id d9443c01a7336-2d2a8993ef0mr302834195ad.10.1786400193500;
        Mon, 10 Aug 2026 15:16:33 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb88473sm43484475eec.17.2026.08.10.15.16.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Aug 2026 15:16:33 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH] netfilter: nf_conntrack: validate template helper protocol
Date: Mon, 10 Aug 2026 15:16:28 -0700
Message-ID: <20260810221628.34800-1-kylebot@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nftables compatibility metadata is used to select an xt_CT helper when
the conntrack template is created, but it does not constrain the protocol
of packets evaluated by the rule. A template can therefore carry a helper
for one transport protocol into a conntrack for another.

Only copy a helper from a template when its registered transport protocol
matches the new conntrack tuple. This restores the invariant expected by
helper callbacks and matches the protocol validation already performed by
native nftables helper assignment and the OVS helper path.

Fixes: 0ca743a55991 ("netfilter: nf_tables: add compatibility layer for x_tables")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 net/netfilter/nf_conntrack_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
index 500509b17..419af6f76 100644
--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -205,6 +205,8 @@ int __nf_ct_try_assign_helper(struct nf_conn *ct, struct nf_conn *tmpl,
 	help = nfct_help(tmpl);
 	if (help)
 		helper = rcu_dereference(help->helper);
+	if (helper && helper->tuple.dst.protonum != nf_ct_protonum(ct))
+		helper = NULL;
 
 	help = nfct_help(ct);
 
-- 
2.53.0

