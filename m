Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5032472A6
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 04:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743576; cv=none; b=mHu0m8fcb45qm1eeVFvLM7c+8nC4xgfKY7/EAE1sRq81iwMDxy7cvtFWdkJZ25Ej3r+N4N4IoW/UDYK8UAEqpQf/1ait4jet5Wszi1Sk+inQ7IgxbfRD1YxbXYv6ulih/wl5Jg5ae0XiZ3/4b9IQw//b2UWZ96nwYb3nKTj7KdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743576; c=relaxed/simple;
	bh=OzkT4mDFP0XjS0I9QKkJ+r5c2Uq7+gyJ+CLMbViBigY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jWKkM5cPVRbqO2EHXI3tWWS/GX7o79Mxgs0fejt2htvy+KPibI5EwEypr7sldzMyQRG5L5SBNkcDzTF/kvdfwE5WaCAv0/UNpU5Ff1MzW73Id37EWLfjLydXxKuotaOeUFY4+/nCyShXOTE/1UpsYiuLrOQNB6gaVQg1t3HAGPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKu/Zx2r; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKu/Zx2r"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so2537123a91.3
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 21:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790743574; x=1791348374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7wclsaoUk0/D0pdgXhYjwxz2clMPb6mstI/WhFlPdig=;
        b=EKu/Zx2r0WfVav4+MaAFlD0cxn1Q/nHliNn5q/89ZXCKVNiLJLwURErin2/jeyYBO2
         VOyYmhxNr43m+9c9BxmB2AH1mVPzmBWTKuBylko8jgPhEREoXKXY5GJaZ7jsm4D5jbY4
         3s7Guxbv9qukXNlFXlpm59hWBvlITlnjOpn2Wp0oI/8IqmYdX5IXXkNCSZhszZM2MrAj
         hDdc33Uo9NOv75kOG1ez1OPNMjIY3IuR9Ph8xQlQ7l6birpQfX96nC0WvoQbxccrN/WX
         ZPiRN22cgoltAzZo8qt7u6ypAWuenaKXHkQmbDDZ1ptIosV0UtWCquNgxKjPTSYrWh5t
         2sRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790743574; x=1791348374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7wclsaoUk0/D0pdgXhYjwxz2clMPb6mstI/WhFlPdig=;
        b=V/w/Tnew7YO2U1Imo48mnyxFiljiOTOKVs/KoqbudsVfYgikMJ0KZJ1xy26jj4PMmq
         rXIlNsl7xYKstzJFsv+0AxBfJ/eessceyEJI38IkaKtmOfbjLEkeIHzCqxWwh3atUZ6q
         Bwq972ielrrCZPXzK0+GhffXbe2+7dVwSfg/yR4sbKTe5QwFdfZjonAx4vdKDiChVs9g
         cYYsA4tT+dn6naPh8qt+3G1RoxGNbx/c5KioBs9dsHAyPSQEn22hhrtvhnfkv2waD04G
         OiEzScAmv3AmJYLYqgnhPVu67B+yt2wtAKb2Bt3X3+Kvq2UTYK1hc3eF+/FzM+vfxVvs
         zXZw==
X-Forwarded-Encrypted: i=1; AKwUvBwstsaOrYQQL6PyRgpL0/iZ847ZNU5srYB50BdgH6XPbIo2qBJZk2heG40fkDAs4WjHn0X30O8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGr2GJYSFAi76zAUAWFWIdKooXMOpToiaFV9A0Z7clJHiprLus
	PHZf06QgXJANUjTmZ8qN8pTPGFQSQ/4u9Kb2Xq96DEQWItW/SKYCRxzm
X-Gm-Gg: AYBFou2jK0deTBv2vXCpriKg5R9LP4dkuPg9IMC842PnPv2FNL4hwA+iomWdG2aJCSL
	yehEHO66q0NOOTqXWg1fgOoktzL2CBzoE/QlsMFyf3HwfiA52NCCB/FubsKXS0w0+UdfroP3cyZ
	bXdKoF99ZqNpz1/6pHA7WvrG6WVPMGxsim5y6OTltEgP5b0ySAHk2gT3lBcjA0eo83CwQlLYUWl
	OgTSuh9B+sg250QunpSw3tRUaRdrRSIsifK2feC2TF60w7XPIyHJT0JQDamoT+AzAvXulrZUHIy
	IgqGJ0dg2JbjLEoU9Pb2LDKLlydjQXaxsXUBAyxadgX9vMQamC2rekzBfrMWGRDHHUPZ6UQrPTB
	S/ROfyXm2VXfy6EKE2vzm8Hi1hEvBCpJviW8wqSxAnJbsBDWXNVFMbLNUEeY0ZotGqIo3repFtA
	r5AmLyE5b/2aoFNfcua4iR0+Np9K56jTKgO6dF5E9cZJyKtZ+VTUvJj8c8PaLJV/Hgot4hqZtN2
	RA/F5ahY4ONdCBglAkIflhHxYfKWpS+BtINc7KGyhFHywCXINjfWwx56Hrcq/kl4ApIAw5vP6wK
	ubIwKr8aUg==
X-Received: by 2002:a17:90b:4f4a:b0:39e:4c80:f680 with SMTP id 98e67ed59e1d1-3a4d1544fcbmr259431a91.31.1790743573545;
        Tue, 29 Sep 2026 21:46:13 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cae9ffaesm1339773a91.16.2026.09.29.21.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 21:46:13 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Xin Long <lucien.xin@gmail.com>,
	Vlad Yasevich <vyasevich@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH net-next v2] sctp: copy zeroed stats to user in sctp_getsockopt_pr_streamstatus() when !streamoute
Date: Wed, 30 Sep 2026 04:46:11 +0000
Message-ID: <20260930044611.204739-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an SCTP stream output extension structure (streamoute) has not yet
been allocated, sctp_getsockopt_pr_streamstatus() sets the local stack
variables params.sprstat_abandoned_unsent = 0 and
params.sprstat_abandoned_sent = 0, but then immediately jumps to 'out:',
bypassing copy_to_user(). As a result, when an uninitialized user buffer
is passed to getsockopt(SCTP_PR_STREAM_STATUS), the kernel returns
success (0) without copying the zeroed stats back to user space, leaving
uninitialized data in the user buffer.

Refactor the !streamoute check into an if-else chain so that when
streamoute is NULL, params is zeroed and falls through to copy_to_user(),
copying the zeroed stats to user space and setting retval = 0 once before
returning.

Tested in QEMU against Linux 7.3.0-rc3 using an uninitialized
sctp_prstatus user struct passed to getsockopt(SCTP_PR_STREAM_STATUS) on a
freshly created stream: on the unfixed kernel the user struct contains
uninitialized stack garbage; whereas with this fix applied, getsockopt()
copies zeroed stats into user space and returns 0.

Fixes: 28b7eab0f910 ("sctp: add SCTP_PR_STREAM_STATUS getsockopt")
Cc: stable@vger.kernel.org
Reviewed-by: Xin Long <lucien.xin@gmail.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Re-target subject tag to [PATCH net-next v2].
- Remove redundant retval = 0 assignment in !streamoute block and fall
  through to copy_to_user() as suggested by Paolo Abeni and Xin Long.

 net/sctp/socket.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index c7b9e325ec1c..1aa475d9dfdb 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -7569,11 +7569,7 @@ static int sctp_getsockopt_pr_streamstatus(struct sock *sk, int len,
 		/* Not allocated yet, means all stats are 0 */
 		params.sprstat_abandoned_unsent = 0;
 		params.sprstat_abandoned_sent = 0;
-		retval = 0;
-		goto out;
-	}
-
-	if (policy == SCTP_PR_SCTP_ALL) {
+	} else if (policy == SCTP_PR_SCTP_ALL) {
 		params.sprstat_abandoned_unsent = 0;
 		params.sprstat_abandoned_sent = 0;
 		for (policy = 0; policy <= SCTP_PR_INDEX(MAX); policy++) {
