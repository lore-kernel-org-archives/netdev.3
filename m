Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97F43EB7FB
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791456598; cv=none; b=PqcPHNFxcc8TkYE6xNv2EIcEN6qLEA2TqqYvlITVBTnnbwgsMQH9n1DG9kgqFyX7N5sqVQDcS7bhYWdiBAv0Ej74qcF8joBqdXZxqNBcaW2dUW874LwJufOJvmrcjDnvbf0VYHJ1aiQKhn1S4E6W7b1ZnB7b/zCwwPbZWLEZl3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791456598; c=relaxed/simple;
	bh=ZVqPaMj9OBKmp7Fn9d0f7hf6S0qpLN+SZH0ehciTrYI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cenjHBFPVJm0vaQbxWbJfK4bUOlnYUNbpLCRXnkx9zV/WhxoO1SLJbCktJlXbj1r6zXFONSPvuFCbW4u61xySK7HDDQ9wQPZgtRPWRMcDMl5n6yUjmwB33lI5DJN9ViNcEvNoSmqroN8bvybpf874w5ptC5wd5eIXYIeHcDuFIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6zLTMNO; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6zLTMNO"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-15354aa70e8so1219414c88.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 03:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456596; x=1792061396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JcYKjibBDVYYKXsTs/kEMk8DPe0X6aXUqJTngq/c/Sk=;
        b=Q6zLTMNO8bCKkznV/pcLT/3OfNDnvzk2krc/+HA8pGXKUKE1QzXETqtdZGfct0b4ig
         Ks4Ov3+UBM/4QTobwsplimwwILaRMSyPs9+JQJVk8mg81TzdAr+HqQasrh3OuQwTSSQ1
         hu10cVJY9Ob6pTHZxZQpHlPMZ1IjPsDomG7sMobME0dmeSm9wAok2DSwegKjsmcCSjK7
         BBevP0fp5dMj8/o5lWJN40BCwJXSzDAsdaPriTekTRqnduYiy8FzS4h6cbhUgyKJKPqp
         vr/lE2SAStbvyWSLADVP19I+bzcsnW2obCKpdw0h3xdnACEqi0H4ZkDOV+Czho6fthHx
         jJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456596; x=1792061396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JcYKjibBDVYYKXsTs/kEMk8DPe0X6aXUqJTngq/c/Sk=;
        b=LHUnotYrLiC00idOoO23tqfWCO8qsF7AbsAIFCo/Ag30o2iRIsEWYrcovg1HX63U8p
         HJK/+0FeaZ750/ADcBXyo+BTHCshT2oae7WFHBje6qkTxYyvsH2YRupVXFkrMu/sfK5i
         hwz5Hb6V243a+jKEd3Hp8+M/wJBHPoA7/Ly30kiMGZHDHbK7v5FCdw8VeyQaDhbNs/38
         0IVsdz/jI22Md9WvF5B+FPut//nqPHxvcslAwoAgA7Q4QHrVNouyNCfN/0Xqh7lRz9KF
         HiuKnRfWBa12+Vwacl3sN+vstAR3g83GDVR9nQaWijspj5nVBBlQn7EthDDYjWORjl5+
         TPmQ==
X-Gm-Message-State: AFuF++k9mow0S6G9PEjdxyTVTct3rj6lyyTyD8UKfZjCiX6Ytn+TOO81
	9ViNWmL6hOFtVk5hDZmPro7mPualmmpCq9e9o42U0JluuYuEr1+f0bCv
X-Gm-Gg: AYBFou00ZwLNTcRH3bpBXizxdCOLKfVZMWNRCQvHNY2AkvF1Jxi2nTryBN8vMTTjWIW
	gt74YBcc/7ukHWOzsDlEnFw+SffxFQQSe7bxtizQR7y9vudMYSNnjjqQ9Gz4MPLyYHQr46Hvakc
	9+hvJNcqoJnzD1ztrO98LwuLeTOuH8q6gccuAMa4SWglxXcndgAfYVAr6R3JMajuvTz273BrGm6
	Wp/7l5iHlSTyragpLMeUV2DJkV6f2Ms0kRuNcm0AblFS7Hm3WrVsHvB7EFX3mSVCKt7rUbDsEqN
	0sAlRe9sXnm9z+LGs7ECg/Ze+l6pcWEM46hK5/NUHa/l90+qENvYCPAmN2G9I4jaT0GKo8dXiea
	JEgVqJsO+S4vkjxrcyMNrKyrTRO62SLjsA/CObDaTN0JbiqMDnpuJpj1/6iAVhjKQIAm3tVdvB1
	S7AWhuPde99xAhtPsFDRVk2NPJGXDFyn4QzpaprEZ3foGHe8t947qTbRJJLk/t9mQjCTOHN/BaB
	FFbwgv0
X-Received: by 2002:a05:7023:a8a:b0:14d:baf5:c40f with SMTP id a92af1059eb24-16205db7867mr7233939c88.14.1791456595585;
        Thu, 08 Oct 2026 03:49:55 -0700 (PDT)
Received: from ramesh.. ([124.123.89.203])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1616b01c2b4sm12797756c88.20.2026.10.08.03.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:49:55 -0700 (PDT)
From: T S Rameshkumar <rameshsv06@gmail.com>
X-Google-Original-From: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
To: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	petar.sakic@ink.fish,
	T S Rameshkumar <rameshkumar.t@phytecembedded.in>
Subject: [PATCH v3] mptcp: push queued data on passive TFO subflows becoming established
Date: Thu,  8 Oct 2026 16:18:40 +0530
Message-Id: <20261008104840.131986-1-rameshkumar.t@phytecembedded.in>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With TCP Fast Open on an MPTCP listener, if the server application
writes data while the passive subflow is still in SYN_RECV (after
consuming the client's SYN data but before the MP_CAPABLE third ACK
arrives), __mptcp_subflow_active() refuses transmission and the data
is queued into the msk write queue.

When the MPC third ACK arrives, the subflow transitions to
TCP_ESTABLISHED and is marked fully established in
check_fully_established(), but because the third ACK carries no
DSS data, the queued bytes remain stranded until the peer sends
more data.

Fix this in check_fully_established() by checking if the subflow
was doing passive TFO (subflow->is_mptfo). Under mptcp_data_lock(),
flush queued bytes via __mptcp_check_push() and clear is_mptfo.

Reported-by: Petar Sakic <petar.sakic@ink.fish>
Closes: https://lore.kernel.org/netdev/CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=X3qf6QycjfKBw+8snPg@mail.gmail.com/
Fixes: fb7084501a61 ("mptcp: add support for TCP_FASTOPEN sockopt")
Signed-off-by: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
---
v2 -> v3:
 - Move the push and is_mptfo reset directly into check_fully_established()
   under mptcp_data_lock(), avoiding any potential race in subflow_state_change()
   which could clear is_mptfo before check_fully_established() processes the 3rd ACK.
v1 -> v2:
 - Use __mptcp_check_push() under mptcp_data_lock() instead of mptcp_push_pending().

 net/mptcp/options.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ce0de02f5..b865ee6af 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1042,6 +1042,15 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 
 	mptcp_data_lock((struct sock *)msk);
 	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
+	/* Passive TFO: the application may have written data while the
+	 * subflow was still in SYN_RECV; __mptcp_subflow_active() refused
+	 * it then and nothing else spools the msk write queue when the
+	 * MPC third ack (no DSS) arrives. Push it now.
+	 */
+	if (subflow->is_mptfo) {
+		subflow->is_mptfo = 0;
+		__mptcp_check_push((struct sock *)msk, ssk);
+	}
 	mptcp_data_unlock((struct sock *)msk);
 
 check_notify:
-- 
2.34.1

