Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0E13A8FE1
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476015; cv=none; b=TWk+dif3+IUCpJXE+fg5gDOy4kPbncsHCxiD4HeETxqsZS+/hst7rIVlCqncbW3iUunPh7JGaCLttMqRMx+8wiQMJSk+SYvBtbD/E/ZQsGqGpt/J3J0DIuKeYCfDo/SxtQnFT0PlXy9IlsBXR0r/AxUF0lDs1CW1amFin2rxesA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476015; c=relaxed/simple;
	bh=vreCvApWOinCDgRvjiXe53vKG1KPRHfHo87+JyZ86wI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXPy5EhWO6MR8pQ0LB6QypSEfT5o68zlm3SQOEajLaZCg+VqBBw3JlfZBXCBJrHxQ7RqEHgzBIRhobhjlOjmt3PgPCBkJoYXI0GDtEWxoyLY6EUNBBiF+i/MggXJFq+NyREpRzoWMCb1gxICfLjwVK1jSXTMSYO+I+hIQTYc90o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rN41TpWy; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rN41TpWy"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso2113270f8f.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 09:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791476007; x=1792080807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PU5L+eEs/MfHmLuLjuMaOq23hdNDnQ5u+me0YnyFa9M=;
        b=rN41TpWyI+HQGD7baW7+T18VkS5wqFTm0dY1epNxz9KN3eekF9iAnzluRxE1M6NaPS
         02dednRH1js26Uahc2biq0f5FhfKMCpxJJBE8LQHj4oLBsd8H/T6k9lbkpls0JM8Zta8
         0aZPzROahR17J0x9H7NRpUGCU7/zlmAoFRMYXuHkdWe1DEspH78acSmlkfw0A5HQzlti
         nIyYg2J9j7cWCyhHDetdR+AzxY3c82HXbxIeCc1O1ebFWb7W/GEc31R9TVZEoMLpAMj8
         4gNR0qeHvViHcRlbzAMKG6xVjOiWBPWKopenXSHc4ZGt9N1forZBuSt9lOyQ9QCCtIfH
         x7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791476007; x=1792080807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PU5L+eEs/MfHmLuLjuMaOq23hdNDnQ5u+me0YnyFa9M=;
        b=UlfeNN80JrNYAhiTwGPUioFBsWJQgc2DCqs5l5Ee19Ciz67ksDOUamUhJTJ4273ZAn
         7NtNHWtGyT2GANf3MHbjcCF+hnhq2oRpUgStNzoF4aO6ol6uPOI3GQ2tM/jTR7q89yaw
         J9C58vx//uMXC4sVbOvN4wy6mSDBxD6S+L60OGVmZ/GNCp5phroSWVJco+4Nn6RDbHZB
         74LP2h57tMJ8QSGPRAtX7n4MS1lL1S4DEy9QDQHYAVlGRgdq8uq0Cw8D/86AwLVGBxUP
         3cWCwMZVGWSQsqW9gQJ+kZ/m1c0LcHKG2fbtnvgKhbpcSCBtm/8u3EU6oi6g4DZuQqSm
         ixdA==
X-Forwarded-Encrypted: i=1; AKwUvByiBQSTGE31YPBhcADgGQ3OLM2dyZ1YzbUvVVJStADBGczdeXyrM8Z37lKDsaw4bO05WaeYmQU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWxvQdmYvCjj7NiyEQsEdTDAhQka3z+MKoMDhoaVQLv2dn0g61
	FQtYaWz0JJo4CjDMJlnCx9JKHBrpFKfS0tSddvxLKcDEv9xPTkyqbwou
X-Gm-Gg: AYBFou1PwV/K6FqJHvmwhLbRMdlgFIF7PyPKlP7E3o6ZBq8rWybCU2mMPdoi8SLO/SE
	/40JVi53LI3+q7aC5iNZJKV/aH6hnVKW+jT/cBFjl5BROKAEGSlnKeKi2qNKDDS6sXy7psqoG+0
	FY3cbMZHZ8pE0nmlpXFyqoB96GCrW2VmJIZMp4PiKDaxr+Gb841dtbD8v1c3tlk93/3YqTQu4WL
	D4K3DqRtPBbVXe8Gqjukma6D+NWu4Tw2F6RHsLplb3DcYjJCd43SzS6vs9LEGGMjN7YD4l7Pvwl
	+VVHPkUIAFJ1FzxFGr26fwWgAd9/PCCCYORGzXDWhxlJrTEV6ViRgXBx3I3qtOkHxwIaZkBtaHP
	b6SsrnGDil2AIOExvPFjd/FHba2A+gE2hu8uPMrrOnIzpLwCWMBolsBeLXtd109dbqPWTDvv7NC
	RVk0IByVZclX4KZ4UdDDqSgrppoMHwqEGq7C+ZMBKfHkUBt21IJgChp0MNVEDlW27vxOHHMpfX2
	2I0nxzj5beFzi8n4ZGeYIJLBPODtwaPFUqwXQ==
X-Received: by 2002:a05:6000:2505:b0:487:ae2:4d01 with SMTP id ffacd0b85a97d-48c727821b8mr11753512f8f.22.1791476007329;
        Thu, 08 Oct 2026 09:13:27 -0700 (PDT)
Received: from MacBookAir.home.tenber.ge ([2a00:6020:a725:dc00:95bf:d5d1:d7d8:747f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db63401desm448005f8f.0.2026.10.08.09.13.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 09:13:21 -0700 (PDT)
From: Jan-Gerd Tenberge <janten@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	kuniyu@google.com,
	willemb@google.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 1/2] bpf: Revalidate iterator programs on link update
Date: Thu,  8 Oct 2026 18:13:08 +0200
Message-ID: <20261008161309.8179-2-janten@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261008161309.8179-1-janten@gmail.com>
References: <20261008161309.8179-1-janten@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Iterator link creation validates constraints that depend on both the
program and the selected target. In particular, map iterators compare
program access sizes against the target map, and sleepable programs may
only attach to reschedulable iterators.

BPF_LINK_UPDATE only checks the program type, expected attach type and
attach BTF ID. A program rejected on direct attach can therefore be
installed by first attaching a compatible program and then replacing it.

For array maps, this allows an oversized value access to cross the source
map allocation. An isolated runtime test used the bypass to overwrite the
refcount of a separately allocated live map. Dropping one legitimate
reference then freed that map while a verified BPF program still held
another reference. After a same-size map reused the slab slot, the live
program accessed the replacement through its stale map pointer. The same
bypass can also corrupt a live map's ops pointer and panic the kernel.

Add an optional target validation callback and invoke it, together with
the sleepability check, before replacing the program. Factor the existing
map element, sk_storage and sockmap checks into validators shared by attach
and update. A failed validation leaves the old program attached.

Fixes: d6c4503cc296 ("bpf: Implement bpf iterator for hash maps")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jan-Gerd Tenberge <janten@gmail.com>
---
 include/linux/bpf.h       |  3 ++
 kernel/bpf/bpf_iter.c     | 15 ++++++++++
 kernel/bpf/map_iter.c     | 58 +++++++++++++++++++++++----------------
 net/core/bpf_sk_storage.c | 24 +++++++++++-----
 net/core/sock_map.c       | 26 ++++++++++++------
 5 files changed, 87 insertions(+), 39 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0ecb9418dfbd..5aa786eba3ea 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3007,6 +3007,8 @@ struct bpf_iter_aux_info {
 typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
 					union bpf_iter_link_info *linfo,
 					struct bpf_iter_aux_info *aux);
+typedef int (*bpf_iter_validate_target_t)(struct bpf_prog *prog,
+					  const struct bpf_iter_aux_info *aux);
 typedef void (*bpf_iter_detach_target_t)(struct bpf_iter_aux_info *aux);
 typedef void (*bpf_iter_show_fdinfo_t) (const struct bpf_iter_aux_info *aux,
 					struct seq_file *seq);
@@ -3024,6 +3026,7 @@ enum bpf_iter_feature {
 struct bpf_iter_reg {
 	const char *target;
 	bpf_iter_attach_target_t attach_target;
+	bpf_iter_validate_target_t validate_target;
 	bpf_iter_detach_target_t detach_target;
 	bpf_iter_show_fdinfo_t show_fdinfo;
 	bpf_iter_fill_link_info_t fill_link_info;
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index b40eb404adab..024419b3dd0a 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -409,6 +409,9 @@ static int bpf_iter_link_replace(struct bpf_link *link,
 				 struct bpf_prog *new_prog,
 				 struct bpf_prog *old_prog)
 {
+	struct bpf_iter_link *iter_link =
+		container_of(link, struct bpf_iter_link, link);
+	const struct bpf_iter_reg *reg_info = iter_link->tinfo->reg_info;
 	int ret = 0;
 
 	mutex_lock(&link_mutex);
@@ -424,6 +427,18 @@ static int bpf_iter_link_replace(struct bpf_link *link,
 		goto out_unlock;
 	}
 
+	if (new_prog->sleepable &&
+	    !bpf_iter_target_support_resched(iter_link->tinfo)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	if (reg_info->validate_target) {
+		ret = reg_info->validate_target(new_prog, &iter_link->aux);
+		if (ret)
+			goto out_unlock;
+	}
+
 	old_prog = xchg(&link->prog, new_prog);
 	bpf_prog_put(old_prog);
 
diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index c19b360bad9e..d038b795bf4e 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -97,13 +97,40 @@ static struct bpf_iter_reg bpf_map_reg_info = {
 	.seq_info		= &bpf_map_seq_info,
 };
 
+static int bpf_iter_validate_map(struct bpf_prog *prog,
+				 const struct bpf_iter_aux_info *aux)
+{
+	struct bpf_map *map = aux->map;
+	u32 value_size;
+
+	switch (map->map_type) {
+	case BPF_MAP_TYPE_PERCPU_HASH:
+	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
+	case BPF_MAP_TYPE_PERCPU_ARRAY:
+		value_size = round_up(map->value_size, 8) * num_possible_cpus();
+		break;
+	case BPF_MAP_TYPE_HASH:
+	case BPF_MAP_TYPE_LRU_HASH:
+	case BPF_MAP_TYPE_ARRAY:
+	case BPF_MAP_TYPE_RHASH:
+		value_size = map->value_size;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (prog->aux->max_rdonly_access > map->key_size ||
+	    prog->aux->max_rdwr_access > value_size)
+		return -EACCES;
+
+	return 0;
+}
+
 static int bpf_iter_attach_map(struct bpf_prog *prog,
 			       union bpf_iter_link_info *linfo,
 			       struct bpf_iter_aux_info *aux)
 {
-	u32 key_acc_size, value_acc_size, key_size, value_size;
 	struct bpf_map *map;
-	bool is_percpu = false;
 	int err = -EINVAL;
 
 	if (!linfo->map.map_fd)
@@ -117,33 +144,15 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
 		goto put_map;
 	}
 
-	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
-		is_percpu = true;
-	else if (map->map_type != BPF_MAP_TYPE_HASH &&
-		 map->map_type != BPF_MAP_TYPE_LRU_HASH &&
-		 map->map_type != BPF_MAP_TYPE_ARRAY &&
-		 map->map_type != BPF_MAP_TYPE_RHASH)
-		goto put_map;
-
-	key_acc_size = prog->aux->max_rdonly_access;
-	value_acc_size = prog->aux->max_rdwr_access;
-	key_size = map->key_size;
-	if (!is_percpu)
-		value_size = map->value_size;
-	else
-		value_size = round_up(map->value_size, 8) * num_possible_cpus();
-
-	if (key_acc_size > key_size || value_acc_size > value_size) {
-		err = -EACCES;
+	aux->map = map;
+	err = bpf_iter_validate_map(prog, aux);
+	if (err)
 		goto put_map;
-	}
 
-	aux->map = map;
 	return 0;
 
 put_map:
+	aux->map = NULL;
 	bpf_map_put_with_uref(map);
 	return err;
 }
@@ -172,6 +181,7 @@ DEFINE_BPF_ITER_FUNC(bpf_map_elem, struct bpf_iter_meta *meta,
 static const struct bpf_iter_reg bpf_map_elem_reg_info = {
 	.target			= "bpf_map_elem",
 	.attach_target		= bpf_iter_attach_map,
+	.validate_target	= bpf_iter_validate_map,
 	.detach_target		= bpf_iter_detach_map,
 	.show_fdinfo		= bpf_iter_map_show_fdinfo,
 	.fill_link_info		= bpf_iter_map_fill_link_info,
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 1d295a8769fa..0cae873f3ceb 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -846,6 +846,18 @@ static void bpf_iter_fini_sk_storage_map(void *priv_data)
 	bpf_map_put_with_uref(seq_info->map);
 }
 
+static int bpf_iter_validate_map(struct bpf_prog *prog,
+				 const struct bpf_iter_aux_info *aux)
+{
+	if (aux->map->map_type != BPF_MAP_TYPE_SK_STORAGE)
+		return -EINVAL;
+
+	if (prog->aux->max_rdwr_access > aux->map->value_size)
+		return -EACCES;
+
+	return 0;
+}
+
 static int bpf_iter_attach_map(struct bpf_prog *prog,
 			       union bpf_iter_link_info *linfo,
 			       struct bpf_iter_aux_info *aux)
@@ -860,18 +872,15 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 
-	if (map->map_type != BPF_MAP_TYPE_SK_STORAGE)
-		goto put_map;
-
-	if (prog->aux->max_rdwr_access > map->value_size) {
-		err = -EACCES;
+	aux->map = map;
+	err = bpf_iter_validate_map(prog, aux);
+	if (err)
 		goto put_map;
-	}
 
-	aux->map = map;
 	return 0;
 
 put_map:
+	aux->map = NULL;
 	bpf_map_put_with_uref(map);
 	return err;
 }
@@ -898,6 +907,7 @@ static const struct bpf_iter_seq_info iter_seq_info = {
 static struct bpf_iter_reg bpf_sk_storage_map_reg_info = {
 	.target			= "bpf_sk_storage_map",
 	.attach_target		= bpf_iter_attach_map,
+	.validate_target	= bpf_iter_validate_map,
 	.detach_target		= bpf_iter_detach_map,
 	.show_fdinfo		= bpf_iter_map_show_fdinfo,
 	.fill_link_info		= bpf_iter_map_fill_link_info,
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 38df84284328..31f7c3a1667e 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1933,6 +1933,19 @@ int sock_map_link_create(const union bpf_attr *attr, struct bpf_prog *prog)
 	return ret;
 }
 
+static int sock_map_iter_validate_target(struct bpf_prog *prog,
+					 const struct bpf_iter_aux_info *aux)
+{
+	if (aux->map->map_type != BPF_MAP_TYPE_SOCKMAP &&
+	    aux->map->map_type != BPF_MAP_TYPE_SOCKHASH)
+		return -EINVAL;
+
+	if (prog->aux->max_rdonly_access > aux->map->key_size)
+		return -EACCES;
+
+	return 0;
+}
+
 static int sock_map_iter_attach_target(struct bpf_prog *prog,
 				       union bpf_iter_link_info *linfo,
 				       struct bpf_iter_aux_info *aux)
@@ -1947,19 +1960,15 @@ static int sock_map_iter_attach_target(struct bpf_prog *prog,
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 
-	if (map->map_type != BPF_MAP_TYPE_SOCKMAP &&
-	    map->map_type != BPF_MAP_TYPE_SOCKHASH)
-		goto put_map;
-
-	if (prog->aux->max_rdonly_access > map->key_size) {
-		err = -EACCES;
+	aux->map = map;
+	err = sock_map_iter_validate_target(prog, aux);
+	if (err)
 		goto put_map;
-	}
 
-	aux->map = map;
 	return 0;
 
 put_map:
+	aux->map = NULL;
 	bpf_map_put_with_uref(map);
 	return err;
 }
@@ -1972,6 +1981,7 @@ static void sock_map_iter_detach_target(struct bpf_iter_aux_info *aux)
 static struct bpf_iter_reg sock_map_iter_reg = {
 	.target			= "sockmap",
 	.attach_target		= sock_map_iter_attach_target,
+	.validate_target	= sock_map_iter_validate_target,
 	.detach_target		= sock_map_iter_detach_target,
 	.show_fdinfo		= bpf_iter_map_show_fdinfo,
 	.fill_link_info		= bpf_iter_map_fill_link_info,
-- 
2.54.0 (Apple Git-157)

