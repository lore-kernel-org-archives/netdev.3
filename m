Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334632;
	b=I6FmPcQDB+DvseyhK2y6oe/VxT1aIOxhuVqLI2f00J74aoxe/NyXtrRQoWz4Sloo268W
	 U6dnbxW42hDq50z3uxq11CU5NVv62tS/y2GPqeS07BTe/iFTs4fh4gr0IFLgv7/ALc2Mw
	 G7Wa+gSMAUsvaQJVY+vr+6xgjoHHJsKqbxLk0ps65rb0YnpemcBsjsLfJV4lcWizVV/PW
	 rKKo4v0D5cGKkQSlO4XvkP/Y+70k20i+zPlZvGdXVWHOeWA2uL0e2/6UBzsEKnE55ycn+
	 yFmdSR+Ar5a8FNUvYPFc4DkMSSkZYvUTynWW4C+soMUYC/QfNx237cFKc5kX98EX4Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334632;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=/hhXe/4/1hjLuJrh4sAENH/262e85qSobkXzPI6FnBM=;
	b=ToJp0P4Yb0uX6j/7fqXwERAgfRhIvnxMhgr6g6UxZmGjqCLyEljpCprSN+1iK95qQuQE
	 w/z67Q7LDlul7nYILKeS5nzbwpG93oVcfCSe9+/yOSjeN9yqaznp12ov3X/Z2GB6uWvKC
	 DGPls/peKU0A3IVT+oK7h5uvSR3fBkxgk5CjFSbwKhqSpVJmgyQgbmWM3UXmbgZWE6AxP
	 RaPirwrY4NkQWpSNN6D4zmvIQKa2/gc7I2kfRVG/mvIqHLbu+AxXt7pnOvOlVv8Dw50/S
	 TSKleftRofkHdTSyKZASXglUly+RaIcS77uZrPxhBjoawcj5t2Qnh2lJI1g192DA9/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=I7QwPxlG;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F501606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 18:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F501606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=I7QwPxlG
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cdd4dafdce9so965672a12.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 10:17:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794334631; x=1794939431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/hhXe/4/1hjLuJrh4sAENH/262e85qSobkXzPI6FnBM=;
        b=CsqhHynNM6a2duOFYu+rtxlbW/qajKnhj1Z9XuzAJZ5tFVh35KcOM/QgAMkvdUwckF
         Bu02PgLnV2zSaSZoUsyyEftHrqDSa8oxxhi5XvoTRHNYW7xwXBiRynEg5htJAawDisx9
         hZl5aqj71gQsPA6KCI6c64tjcjOF5lOuRZDI6Z/ZfG9NFkNMTng50o4dXeNohZ7SfiaK
         CAlOjoSa+tbjVS6+lSouEG8F4zQoG1Egj+rqBH2cP4rCtTLaVTO8Fs1sIwdMbf337rDB
         wf5D9LcpKF9JE/kmxKZdkCbY17fue/QEdEgwyfBZRXuopylSV7Dfgc/KIs+Uo/hI2T18
         I7Fg==
X-Gm-Message-State: APuU4Z/6euBx+MljDDkMcjO6Aeq6GJX1FtQL+pA97Djj8+ZiCYO4Bb86
	vzweur0EkHqJfax70WmcQk7y7DvwZIu7E7h6I/zCzYsTyqwmetryxXqle0wO/ByQ5w5I2goduMX
	oDV8MkrvHVwB3mlspsGboYe/fzup7KV4fA+u/h4owPQpAGyogtsiPsGlxYY1NewHvvvoUeIkb4X
	GESLCWsgu7BFSfqoUOR3A0aIfZFMTedWFksAulgIKnX15jBUGLY+wn/cjEWlmuBQXPqOBu2xN4l
	0r3nm+c7cA=
X-Gm-Gg: AYBFou2SVFUlOpuj7XNbtpXuqNHN7cpe53X5AADgdG+sM02Ba76KTPoo/Byt6F2GpHj
	FSfowngkcC7tnBpZjbMb5kJyU7L+UGLhzj1xFvmi3IM5CvGfHwZ2nZ4bqMBSHsRaRKqNE98b//J
	00a32rNi/BpX0nX2h2dvWq98V/ls3MuzghbIMKYz01fHJH+WuGRdDUBsqoBBQ8wyvgvvj50vtNk
	Mo9sIE2zXP6udaqStHZWmEmfVLd5hKkIM7BHhXj7G8Buw57u7L+1Z8ktTOFq6VxYPOyUv/2Euz8
	XwO6qlMrIRmAlvwHY6Sg00AT4ZbxMPkXtfPKMELQOIt+DjJix95Ir+I+yQj3U53/UWIX1oSJR1M
	ke4TYn/Ua4sSjfjM0Degom6phCn77MhLXbGGMEnTWgnmSoji41MGa7mNk85USNm6rU4BWaaHRjU
	jXmGeYpUJmAs9tRQZVwLnpbvg9RTD332Ppat0=
X-Received: by 2002:a17:90b:4a0f:b0:3ab:f38:2b43 with SMTP id 98e67ed59e1d1-3b166cf450cmr3521323a91.34.1794334631167;
        Tue, 10 Nov 2026 10:17:11 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b181bf9bb1sm28196a91.2.2026.11.10.10.17.10
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2026 10:17:11 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36fa5673fccso390547eec.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 10:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794334629; x=1794939429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/hhXe/4/1hjLuJrh4sAENH/262e85qSobkXzPI6FnBM=;
        b=I7QwPxlG81BdIbftfsri/Loh17oGXS7Cg1HNB8JCvnEHUG9AxkzdCLjFoGE1dsgcuj
         ZB1h0mHZoGZGbl4oJVS8WKyq/UiHs1Aa63QUZkJcdJXDL+GfhL2997GG02PqMbrsRT3S
         3TNZqQPPS2yZeSi6qsPf40i2SFsUfvpWHNR8o=
X-Received: by 2002:a05:6a00:1305:b0:8a0:3685:23a5 with SMTP id d2e1a72fcca58-8ba86c8b53cmr3324723b3a.53.1794333013328;
        Tue, 10 Nov 2026 09:50:13 -0800 (PST)
X-Received: by 2002:a05:6a00:1305:b0:8a0:3685:23a5 with SMTP id d2e1a72fcca58-8ba86c8b53cmr3324709b3a.53.1794333012894;
        Tue, 10 Nov 2026 09:50:12 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa506bca4sm1241256b3a.0.2026.11.10.09.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:50:12 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	keegan.freyhof@broadcom.com
Subject: [PATCH net 0/2] bnxt_en: Fix PM resume on VFs
Date: Tue, 10 Nov 2026 09:49:41 -0800
Message-ID: <20261110174943.2106347-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The 2 patches fix Power Management resume on VFs when the PF is running
in the same kernel.  The first patch maps the specific PF_DOWN FW error
code to a unique errno.  The second patch adds pre-polling on a VF
during PM resume when the error warrants further polling.  This will
allow the PF to finish resume before the VF continues.

This issue was found in the lab when testing system hibernate on a
BCM57608 NIC with 64 VFs created.  The FW version is 238.1.59.0.

Keegan Freyhof (2):
  bnxt_en: Map HWRM_ERR_CODE_PF_UNAVAILABLE to -ECOMM
  bnxt_en: Wait for the PF in bnxt_resume()

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 51 +++++++++++++++----
 .../net/ethernet/broadcom/bnxt/bnxt_hwrm.c    |  4 +-
 2 files changed, 43 insertions(+), 12 deletions(-)

-- 
2.51.0

