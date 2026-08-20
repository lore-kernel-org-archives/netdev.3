Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA903C9EF4
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 07:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787211862; cv=pass; b=h8R8L22q0+DaHnPxecBpCYpwujpSHcja7Qd8vqMF9ZTUm34WyIO9ZpdGDtcMmka+Tmc+OIO0UlnL9qTLvf/tAGH2zq8LMFwuHJfClhJABcoqTtWMpnr2uYz51QAlwkU1qUh26xFcsDOJMosPq2UdLvA3KzhD/CsTn8n7BRDvJ8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787211862; c=relaxed/simple;
	bh=qblL5K7hDoy6z2OQB7G1qpmMIHaxIOhwHYlwWzA2++w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JJq7HRTcWf5hoy5zr4LVcpzVnfO1AOnJ4XnwG7Gn7eqWuHC6EUArsq1h3zNzIrlxmHAeuWG/lBzG6ByJGqoNDlmVINNTppV8jjYBZg/8UWO1VzJSVXeWpkFA1BRrm5lda4F964xoig8B0SWlnRNX6nsP7CeVIkVaK3wNQ0qiNZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=O32Bwevh; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="O32Bwevh"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c197e7e4e94so325528066b.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 00:44:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787211858; cv=none;
        d=google.com; s=arc-20260327;
        b=dLKGz8b6+1IWIewtwJ2du9IY9DQn69h7qpE21IK3FARCiTaYgUvkbY0UnpEhNcMXqg
         O4l+yUXMKO2tTkeioeCR7O9fJAmtx26aZPLoQW5Iwp6AcnLusNlm++NKAkdKB8APLq0M
         gBMF3+o3ctpJ6eyBv2DtKQgJXBTp/AIxgGOjNOt/ClfWLlHgyl3tPACfAXdW7rNzj9eW
         hZ5AC2Y6wcoagBQJbFFpgN5yFHan36QWsMPnzwZ7QrgmzOG2TnCdD6E0JH3fZu12mgui
         UogVDEO0HMSjbWIHqAQlhwW3B+4NtLOq6OI1TJaNpZAkT6BO5rOq9v8OHtYzyMladqgC
         qjtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=qblL5K7hDoy6z2OQB7G1qpmMIHaxIOhwHYlwWzA2++w=;
        fh=VYON2AchzTHgQKems9QnmXEk3H82yWNgNrU21PukfDA=;
        b=J9DU2jXU6FSgGFlaXUZNpamPb4i3DO+Qdq/oGC1mVmVztNE1m2D2LTRWEhbR7ilOvk
         SuApE/S4ijRiKV7fGVDDuGSzV6FuswOf2cWPC/l3UX8aga643sbkr408mZXxwEG7WgA7
         Hz6vaWY67khzsbxRWfl4LmxeM5fHH3H3Mb75NckTDfOJYcCYGq1p2raKAkcALZNdbJau
         LmMrr6CyDZXLe8QHKtYEFOVhF4LxRSbmhFpN8INCI6oZTX5FGZIMVFqyRmV1B2CeGvfh
         Ff4Gi2/5WfXDz/DUwfCixYOhUJbF4aJ8hXaXZczTrvOYVR9aHUqmZWpiGiV6CrdynoBP
         Npww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787211858; x=1787816658; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qblL5K7hDoy6z2OQB7G1qpmMIHaxIOhwHYlwWzA2++w=;
        b=O32Bwevhzq1YbZr6suoVujv9j1kUgBusVkzqD51HXyGJ5SiFfNovf+Dneo42uRfN+a
         u+z8QzG2loXfNA8t4L6w/ApOiUGXwiFY4MmXjpI5d01z7hksreQx1EF6lUT6MgPDPkb4
         GtJfiLFSDyKMXaukevE3hIZbu99DbU6c88HrR/Oh5b0oA4UGgyuXRwEa3pO8aQ4vIOab
         5Lgdc6OQGyktqyDg8+uiNPCdF4GKWbdv+rZfK0Nv1W7jq18ZLvCVaj3Nq2P+NgBWIOWX
         sAoNgsWQKR2xcI5ldtImdKc9gLE161z31jyE33lcQ+mdPP/GFECL+Wwt7haM14Vp3cc3
         iyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787211858; x=1787816658;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qblL5K7hDoy6z2OQB7G1qpmMIHaxIOhwHYlwWzA2++w=;
        b=oxk5SECLbcGtwdiivegBn/AkXnNr5D9ImIlClvx4BZBXaJyFSyOIsm7Xk7bhvhr81T
         cRXlKfwhNsBTaXKKefPpFF/YPgrmK3Vz+QxcGbhhXtjx9ZaT6oZ0DVORrF7EUkJifRpm
         rVEyDGlyBn4W4LXAe79VzkAmiks7XwxGKuA9wVzOiN4ws9ABVwbmWOttrQAFCpxzzYIH
         IbVC+rngEUoGt5ZCesOzL/+/CetvzuTTK7rcvt7Ab5FJRoNfR9XftXgkrbxPzA2HlFz4
         r7vRyQlrSalgvNueX0ZKiFOobAJ0bvj0bixR3alrsq2YqYk5cq9oJqTNF41Af4dFcFFZ
         JDgQ==
X-Gm-Message-State: AOJu0YzBtKAyz18JFUqgS2Lvu5fUiQfjDFeNe/xkkFrAq+itbzT7T+wv
	JLuvJQOlGPgAVRJDz3AJV5YPkFZ5d1uzzVnojgInvZa4r0l8jHLZPfaYbT4ATC11R/NnyOKwgCE
	9DC3l4jaBaRQpux0ymBRBapk7tDNU5n1/XvX3TNKILyZ2iUaBdVQTKY8=
X-Gm-Gg: AR+sD12LlS1l0rXVu3jYhnJ8x/p9QhmiW7tOoVkGQyBNsJcHnnRZ67wJ2rBCU7Li8Jt
	xK55nrXrq2ZpDgpM5MzMaoAPiKdBMPBYT1vwfsi55jZaBI5zRlLGHYLXksuyu8CwzlLmn4VYa1D
	P+0F3iAbXzse8lLGIJ/Vcnd8F6Fy04M2cg/1t+LA1APMCaFsxXrLLhysAA+zIH/ZYvw1vbAx2PP
	3NTOIXNw2TShVnmRtVkvx3zMGf7zvWPXrSXV4xdQFfhCB6JZrvBQVvfmdrG4D4c1IjCp5HlnKUB
	6Id4AwFXxhD5C8FvsBx+WyuMXBbkvCKYJ/4uMGw92BzI1czj9S1xRzP651oaIP3UQdmUovD3og=
	=
X-Received: by 2002:a17:907:9307:b0:c21:450d:cd88 with SMTP id
 a640c23a62f3a-c23f936e874mr646819666b.6.1787211857891; Thu, 20 Aug 2026
 00:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 20 Aug 2026 09:44:06 +0200
X-Gm-Features: AcwNN1WYliKAFAcz8NUi8mIS6Z7tSILNli4M3PRUKj5FVlc4VYbogqNmwFk7o6s
Message-ID: <CAKPOu+-x_QPgp7gvApKNxd=aAONgNUmQQMbiLKwQghWd6u7Y=A@mail.gmail.com>
Subject: 6.18.45 regression with bnxt_en due to uninitialized RX page size
To: stable@vger.kernel.org, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

after updating our servers to 6.18.45, the bnxt_en NICs would fail to
initialize:

 page_pool_create_percpu() gave up with errno -22
 bnxt_en 0000:c4:00.0 eno12399np0: bnxt_alloc_mem err: ffffffea

The regression appears to have been introduced by the backport of
ad9ffc61fafeb ("eth: bnxt: support qcfg provided rx page size"). It
obtains rx_page_size from the per-queue configuration:

 rxr->rx_page_size =3D rxq->qcfg.rx_page_size;

The bnxt_en driver installs queue_mgmt_ops only when
BNXT_SUPPORTS_QUEUE_API() is true. On some NICs (like ours),
ndo_default_qcfg is never called and rxq->qcfg.rx_page_size remains
zero, leading to bnxt_alloc_rx_page_pool() failure with -EINVAL.

This was fixed in master by:

 1410c7416dc3 ("eth: bnxt: always set the queue mgmt ops")
 3cf48c04966e ("eth: bnxt: make sure we populate the qcfg defaults on
old FW/HW")

After cherry-picking these two commits on top of 6.18.45, the error
disappeared. I suggest backporting them.

--=20

Max Kellermann

Principal Software Engineer
Hosting Technology

cm4all GmbH | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
E-Mail: max.kellermann@ionos.com | Web: www.cm4all.com

General information about the company can be found here.

A member of the IONOS Group
