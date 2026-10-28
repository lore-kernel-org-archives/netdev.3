Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793176086;
	b=UPNoGlWlBlKvj+btiiymZBAteNs4H1FyHcQPFspF9izXlYiKLpKLGjwJXp3Irf7/uPYw
	 yZ8+8xjLO/wP+w4i7CwArQcz60ksYY+5YFwm7fTJ6gaUno9Wje9yJDkykzxqM5WgHeorl
	 DpfHG1A7GpPQq8Xrl/UHNZB9vfrnK5VfIg0ZsJvPt0n7JRslluxS5C7dooddQXcXqlhNf
	 rVcFzjt9Azjm6oR+IEP0uexD0SuEFdOW3ycM3KnCum04GxUzoEamsofq1UQ0T3MTQTPCl
	 +n9x4qlylj5pr433ccD43lkSL2dVcgtk4mOwZorTfbASnD8Bg88O2N12ycDWKSHVfeg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793176086;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=0bnX4zX60YCKha46Olc23P+m1jc7sXIyWg6WYH4xiMU=;
	b=AOVqfPSJH5PkxUmabihW1b8EJ/jYEGF9Io9rsObUBcVklXQRea6ox5g4kbJjzbPqDJQc
	 VAMV/vvvgwq/XZDSeUEe6T6k5zOCmnwvuSjLMlUSosIpRHEsl6podaxkmIVfWhxsOJm+R
	 BDABeInwTAgsziLTKupbmjjCKw5v9vOWTtYEOE62XGI/P7MSXfnbjRVJj8vEN1fITmFMB
	 64aRmdFlcRSSkPNhGaTyDYs09rURsCpYb4WPV6ow+9MY/mnZKHBiqjKovoIMpkvJR2Wb+
	 5NQ+VbPLHx16iYGYJ8p6c7gftvlBfDA90oZH+moyTDbVGQW2ejhIFG0tvqOc1PipF4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42232606A325;
	Wed, 28 Oct 2026 08:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42232606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1793176061; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=K9KXXsIoeflA+v9Z3fkrILA9gvzbeazaV1aAIC13VANv8uX1m7Jwcp8S+CaobepRlZPuzkBwd+tfHCpd2DNe830PT3IdVAD8xx92vImUCikN52QfDeLPnq0/hAMqC19EqoeqGdlh1wnKi5nnIAL8DB3rdBId+xg41fWSpE4T3T4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793176061; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0bnX4zX60YCKha46Olc23P+m1jc7sXIyWg6WYH4xiMU=; 
	b=C7WGm5F4sxQnVOjvPXsf+e+7m44Qx7g16VKSoVtGhO+RUyJphK/jiQashg3THOor/sDhT+VElOHyVaXzXxqdPC27inxtw4OX6pl118DaGsJxzIwDDo3ujOEuDFeDON6jA/umb8XzCPIdfZFfbI82tIwLR8R0XXAjqPDEFSmEgLk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793176061;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=0bnX4zX60YCKha46Olc23P+m1jc7sXIyWg6WYH4xiMU=;
	b=T+sbWaTE7xO5jaYbVPfVvlRYoaES3heyLxul6sxLS4/Rs8T3E2WVXw6rQL8kGA0J
	s5TgU+JuUTxqyTlT4Hrn40qKCHDQ0y3eY+hDDIh6yEDLVt4d5dmqoPA2r5N0XYJlpsU
	KIws2U4lhIhVtgBEErF1uJG1kxDwZhzPtNt+dT94=
Received: by smtp.zohomail.com with SMTPS id 1793176059486104.36534309557874;
	Wed, 28 Oct 2026 01:27:39 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next v11 2/2] mptcp: hide seq counters without net_admin
Date: Wed, 28 Oct 2026 13:57:01 +0530
Message-ID: <20261028082704.1609493-3-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028082704.1609493-1-kalpan.jani@mpiricsoftware.com>
References: <1ec0c2b5-a0fa-44e8-9ae8-dca9b7f90ec6@kernel.org>
 <20261028082704.1609493-1-kalpan.jani@mpiricsoftware.com>
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
X-ZohoMailClient: External

The MPTCP inet-diag response includes data sequence numbers that
should not be exposed to users without CAP_NET_ADMIN.

Clear mptcpi_write_seq, mptcpi_snd_una and mptcpi_rcv_nxt in diagnostic
responses for unprivileged users. Apply this restriction in the
inet-diag callback, leaving the MPTCP_INFO getsockopt path unchanged.

Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
 net/mptcp/mptcp_diag.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index 9ed7a6be1e628..970f849f4345c 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -215,6 +215,12 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 		return;
 
 	mptcp_diag_fill_info(msk, info);
+
+	if (!net_admin) {
+		info->mptcpi_write_seq = 0;
+		info->mptcpi_snd_una = 0;
+		info->mptcpi_rcv_nxt = 0;
+	}
 }
 
 static const struct inet_diag_handler mptcp_diag_handler = {
-- 
2.43.0

