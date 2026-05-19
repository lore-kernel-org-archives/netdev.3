Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145413E7BB0
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227955; cv=none; b=patlsfys3pSippJkCFH0zKMOVAEGO+NEJk5MxAq3N6wckw3aFqxsmhLJaqtBlpkuYIUPVmEr/YpmhMF1h8HryzdYXDNmtxe4HGKlrkbLmKR4gCfPIR2DBuCONH9ccQOCkpTcBaSK1EysQhy079cYbpmssbjGiZxj3MVU205h0DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227955; c=relaxed/simple;
	bh=+rfnj4QnnOYGyDCpppuPP2TiOGyFsjPCa/gzWos4Hzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcFIywgfEd4wKiMLVUvpwCGwCecYJx4qLu8NZFFvxPGM5UbCUgbPwRuO6sTfyxSgDxxkdGWRXuh2tEMCr77aGRc9jKL3D8m3jN684oUG2zDQSEOOfwkDfXydsLJZUHMH9xYNVJ5oI3k/i3B5SwCKLk+O0zPCehfrxXEGGIaVt5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tRsCoZdt; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tRsCoZdt"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779227951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LCXw97qlulha7oHoZkSW7OTUpRrUdsbmlMhHwgO81yg=;
	b=tRsCoZdtJlKSH9ErDufq/L9Y+rgUVIm4/uf3xFmghm2xYQrJzSLKBX72PWUoj3dAk/CTqG
	cikjJeFWDYaffMUsKwf/ba8SRnXDJ4Wgb8I1TFhq3T78Ue+DjCcEZzM6mhXL9xW8SLpS6v
	XYBpcxvZcudXA5OAyYcZFjd7vCdMAeU=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	'Shakeel Butt ' <shakeel.butt@linux.dev>,
	'Roman Gushchin ' <roman.gushchin@linux.dev>,
	'Amery Hung ' <ameryhung@gmail.com>,
	netdev@vger.kernel.org
Subject: [RFC PATCH bpf-next 05/12] bpf: Replace prog_list_prog() check with direct pl->prog and pl->link check
Date: Tue, 19 May 2026 14:58:12 -0700
Message-ID: <20260519215841.2984970-6-martin.lau@linux.dev>
In-Reply-To: <20260519215841.2984970-1-martin.lau@linux.dev>
References: <20260519215841.2984970-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

prog_list_length() and compute_effective_progs() use !prog_list_prog(pl)
to skip a 'detaching' pl.

When pl->link is not NULL, prog_list_prog(pl) returns
the pl->link->link.prog. This does not work for the upcoming struct_ops
patch where pl->link is not NULL but pl->link->link.prog is NULL,
because a struct_ops map is attached to the cgroup instead of a BPF prog.

To prepare for the upcoming struct_ops patch, this patch
replaces the prog_list_prog() test with the
"!pl->prog && !pl->link". In __cgroup_bpf_detach(),
both pl->prog and pl->link are set to NULL, so testing
"!pl->prog && !pl->link" is the same test to tell
if a pl is being detached. This change should be a no-op.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 71591f6dc458..abfd6df349d4 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -387,7 +387,7 @@ static u32 prog_list_length(struct hlist_head *head, int *preorder_cnt)
 	u32 cnt = 0;
 
 	hlist_for_each_entry(pl, head, node) {
-		if (!prog_list_prog(pl))
+		if (!pl->prog && !pl->link)
 			continue;
 		if (preorder_cnt && (pl->flags & BPF_F_PREORDER))
 			(*preorder_cnt)++;
@@ -461,7 +461,7 @@ static int compute_effective_progs(struct cgroup *cgrp,
 
 		init_bstart = bstart;
 		hlist_for_each_entry(pl, &p->bpf.progs[atype], node) {
-			if (!prog_list_prog(pl))
+			if (!pl->prog && !pl->link)
 				continue;
 
 			if (pl->flags & BPF_F_PREORDER) {
-- 
2.53.0-Meta

