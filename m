Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508319;
	b=c3K307DjlTlnEY+FseXox8SfOOucbx04tGkbyAclk/iYVjw88JQr2m0EEiNhxRfniKOa
	 qVxTtQr/2ShbIDWmKxdtwEiT6ysHnX3i3LXx/Ht/C//D3rrjInadTOfJcxrjESUr19Ju4
	 PQ99Ivw//r4LPiewfTVZX29T0R2wze+uVlVH3NQ4eMvDp4cugKPt+c3IR6pjp0DeaSw2v
	 hObAmmegLkUe3377w8f01h/O7iS6HHhqsCaRknxHmzcfNz0Z7GZvvN8daD7Vlr3qg6TzS
	 KzTKKScmVkza33jb2cOzLETeFQpPAIqgYU0wq/DLU6vsqWAyW2ae0SFzzjPWMZTSf4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508319;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=gocN0lUv+ePHb7pN6LNyapCRmaF7S37bTOPeiY6oAS0=;
	b=lpjJftuZUhO24jPJJ+zyEd0mJmexJGlIkSHfm4A8z97wCpcMze+tsZLDPNr9J6EBIdVl
	 Kk9AaJ/nRdhREClv4ddX/5b0rDc/XV7T2795wJOaRHbkpuUTspZNpaBcRtumKwZ4GKcK4
	 m6PtToBs+cmAryR2E7LrbJEdVylUlgvpnJ53QtmRMKS7szFr3jNn5I6G3ZR/me3LNKaCl
	 DXr4vv/Q2LWZ4OCLfB8qkyLYbHfVgKAxXQ4DufvpJRvWgydrF7I6Sfeo6X4ypQ+Dwsjx/
	 jSotth/YwZkjepohLKcTZcX9RQvg7KyN2yTp1pNDsweyny6FnSrKrNZq/cIyvesvWXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MS6xHdyw;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7060260A381A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 14:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7060260A381A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MS6xHdyw
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e95bd1c14cso26895455ad.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 07:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792508319; x=1793113119; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gocN0lUv+ePHb7pN6LNyapCRmaF7S37bTOPeiY6oAS0=;
        b=MS6xHdywJb5spuXqgqSCAqSB0RNnXW7AqREUxfx+vVdDK08lo0LGe0vVHr+Gqy5m5D
         raMBdA6EY8StfTs50bjxWXCkkr4v3FTJf142yBdfbIZ2s+ng8EQnRba5DMhWV5/akqb8
         EOtlvDJFG51mMjOzH6YjdOZP+qnyBmHgCW97qa0pQDKsUYZ17lv6XulT9vUr79BgsCZJ
         ylSKHzYrgGZ92eear0ftWY7AmQp0tMgOk0PYhsy+fkMkxR+X7SyniqvBbZ4K+28V17wW
         17crHjJRHt1ZJkdOEtZ1uZdf0kX3f0pEALSD7Gs0zhf0FjmvvBEHa61CPArJFbMJHGFb
         IOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792508319; x=1793113119;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gocN0lUv+ePHb7pN6LNyapCRmaF7S37bTOPeiY6oAS0=;
        b=o8e4R6mhXgJEw9NLRdeXO/sGZ+Ye7GMRaPPZoFMyD1+LKtTnwgTfltmUGmwNHiTOLL
         yhRYXbML6LxCgRY644MCXI8s2YXiSPhlVeE6C0VwD3tV0oTbKee9stnYZ8cNuumcg/Zz
         yda6SEzbr6d13NXWpNfaI3nQjICCvukHywzGRDSiv3OAelZa+W4vVJLl3lQ4hrXbn/Cb
         p/sVYS2I6MEYSJTLvPBJpee5h20jO5J3B4dm+GmqpNO85POo8c6bhWWXO0658LwHGkgt
         SIFJV9wVL8X4A8oUKfdphfaH3FoXMHzvH5aj3rDU/3f38E8kD26AdyDL+YxXRZKNeoAX
         TpIQ==
X-Forwarded-Encrypted: i=1; AKwUvBxXpHS0GmvGyU0bRy4AKyYn7AfIsmz9GbqvmK1fJ6jO0ZN0SHesuey+71MKDree06gk1cUMJk4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJWp39OLhUzM5PuSUR4FDo0Ve/Gir0/GkIKl6qniz+LA7mtB4I
	8SNkBXdaF4hSDyNnuoTVfAg6+XGGjXO/v/0CDabvVVjM0Gx9njYSUlPY
X-Gm-Gg: AYBFou2wmzRSZL2wuF0z3zgiX9S9+stLjNfvCz/CRbtfzpfJI++QYyXFXrjn+OmDONw
	6IHdb5FDbYUpLfoUzfDC/19AkmjILWE32sF/KaerqcacnQfbBsf4xt8CQpIYOhYES8XCKEcjK2N
	x/W4XVdy1juNyR8ycDey3Fm+SR+gyL9unt77gqpm59aut8bkjvlZRMEHeh2BeB6sB0C406co4MW
	bmoJtmACYFWSiNG+s75nsN3fCKNcmU56gwFbUUZ5th4BLzjo/zFmrfnVhQ0rjO5J2BgovKh0nMo
	mk5nlB8lAvFsXpZ/7IIW9vkYFIx3yKM8Qvp6/AZU2DGGudyZ9amPhZYfLsc9Ir4MEnjdzhNWnvk
	xsTHukAd5V8FjR1/IWPZsoR8rW788kQRYyfs1HAlHL3uxNHJl69PRiS68oGXqzjxOgeQ5W3bIRl
	g1Qv4duNJ5kID+gSd5T4dxS2MbyikbLfjd7U+NSt7lHDgDcsaFWiFTvPWvTutWnPGv6qwi0td6z
	EFi5NFZvgWCvWz3/mctg/9oDE5hBTQq+iuDJQNXOajKlMTgDoxQoasFLX9swRWICpPl/Asf1MJ8
	aqL7Oo11GrxdJA==
X-Received: by 2002:a17:903:2351:b0:2e9:9f14:c40 with SMTP id d9443c01a7336-2e9a684330amr96805845ad.6.1792508318588;
        Tue, 20 Oct 2026 07:58:38 -0700 (PDT)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b40fe7fsm280255ad.13.2026.10.20.07.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 07:58:37 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 14:58:36 +0000
Message-Id: <DM9R60QEU8RP.2MWT9CY6J4ZVF@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>, <john.fastabend@gmail.com>,
 <davem@davemloft.net>, <edumazet@kernel.org>, <pabeni@redhat.com>,
 <horms@kernel.org>, <nathan@kernel.org>, <ndesaulniers@google.com>,
 <morbo@google.com>, <justinstitt@google.com>, <menglong8.dong@gmail.com>,
 <bestswngs@gmail.com>, <mattbobrowski@google.com>, <vega@nebusec.ai>,
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH bpf v2 1/1] bpf: reject raw iteration over managed map
 fields
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Zhiling Zou" <zhilinz@nebusec.ai>, <ameryhung@gmail.com>,
 <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <llvm@lists.linux.dev>
In-Reply-To: <96a6b5dcf721e49c049662cc269d8ac8c389b6af.1792217106.git.zhilinz@nebusec.ai>
References: <cover.1792217106.git.zhilinz@nebusec.ai> <96a6b5dcf721e49c049662cc269d8ac8c389b6af.1792217106.git.zhilinz@nebusec.ai>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Oct 19, 2026 at 11:35 PM Zhiling Zou <zhilinz@nebusec.ai> wrote:
> Revalidate the replacement program against the map associated with an
> iterator link before bpf_link_update() swaps programs. Add selftests for
> allowed prefix access, rejected managed-field reads and writes, and link
> updates that introduce managed-field access.

The sockmap iterator has the same hole.
sock_map_iter_attach_target() checks max_rdonly_access against key_size
at attach time only, so bpf_link_update() can still swap in a prog that
reads past the key.

No need for a new callback that each target has to remember to set.
attach_target can record the limits in bpf_iter_aux_info and bpf_iter
core can check them on attach and on replace. That covers all three
targets. validate_prog, its typedef and the split of both attach
functions go away. Selftests are left out below.

Something like this (compile tested only):

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0ecb941..ffb6fee 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -544,6 +544,14 @@ static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
 	bpf_obj_init(map->record, dst);
 }

+/* Part of map value before the first special field. Fields are sorted by offset. */
+static inline u32 bpf_map_raw_value_size(const struct bpf_map *map)
+{
+	if (IS_ERR_OR_NULL(map->record))
+		return map->value_size;
+	return map->record->fields[0].offset;
+}
+
 /* memcpy that is used with 8-byte aligned pointers, power-of-8 size and
  * forced to use 'long' read/writes to try to atomically copy long counters.
  * Best-effort only.  No barriers here, since it _will_ race with concurrent
@@ -2992,6 +3000,9 @@ enum bpf_iter_task_type {
 struct bpf_iter_aux_info {
 	/* for map_elem iter */
 	struct bpf_map *map;
+	/* how far a prog may access key and value of the map */
+	u32 max_rdonly_access;
+	u32 max_rdwr_access;

 	/* for cgroup iter */
 	struct {
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index b40eb40..6f3ae92 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -405,10 +405,21 @@ static void bpf_iter_link_dealloc(struct bpf_link *link)
 	kfree(iter_link);
 }

+static int bpf_iter_check_access(const struct bpf_prog *prog,
+				 const struct bpf_iter_aux_info *aux)
+{
+	if (prog->aux->max_rdonly_access > aux->max_rdonly_access ||
+	    prog->aux->max_rdwr_access > aux->max_rdwr_access)
+		return -EACCES;
+	return 0;
+}
+
 static int bpf_iter_link_replace(struct bpf_link *link,
 				 struct bpf_prog *new_prog,
 				 struct bpf_prog *old_prog)
 {
+	struct bpf_iter_link *iter_link =
+		container_of(link, struct bpf_iter_link, link);
 	int ret = 0;

 	mutex_lock(&link_mutex);
@@ -424,6 +435,10 @@ static int bpf_iter_link_replace(struct bpf_link *link,
 		goto out_unlock;
 	}

+	ret = bpf_iter_check_access(new_prog, &iter_link->aux);
+	if (ret)
+		goto out_unlock;
+
 	old_prog = xchg(&link->prog, new_prog);
 	bpf_prog_put(old_prog);

@@ -570,6 +585,14 @@ int bpf_iter_link_attach(const union bpf_attr *attr, bpfptr_t uattr,
 		}
 	}

+	err = bpf_iter_check_access(prog, &link->aux);
+	if (err) {
+		if (tinfo->reg_info->detach_target)
+			tinfo->reg_info->detach_target(&link->aux);
+		bpf_link_cleanup(&link_primer);
+		return err;
+	}
+
 	return bpf_link_settle(&link_primer);
 }

diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index c19b360..9fd5920 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -101,7 +101,6 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
 			       union bpf_iter_link_info *linfo,
 			       struct bpf_iter_aux_info *aux)
 {
-	u32 key_acc_size, value_acc_size, key_size, value_size;
 	struct bpf_map *map;
 	bool is_percpu = false;
 	int err = -EINVAL;
@@ -127,18 +126,12 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
 		 map->map_type != BPF_MAP_TYPE_RHASH)
 		goto put_map;

-	key_acc_size = prog->aux->max_rdonly_access;
-	value_acc_size = prog->aux->max_rdwr_access;
-	key_size = map->key_size;
+	aux->max_rdonly_access = map->key_size;
+	/* percpu values are copied with special fields zeroed */
 	if (!is_percpu)
-		value_size = map->value_size;
+		aux->max_rdwr_access = bpf_map_raw_value_size(map);
 	else
-		value_size = round_up(map->value_size, 8) * num_possible_cpus();
-
-	if (key_acc_size > key_size || value_acc_size > value_size) {
-		err = -EACCES;
-		goto put_map;
-	}
+		aux->max_rdwr_access = round_up(map->value_size, 8) * num_possible_cpus();

 	aux->map = map;
 	return 0;
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 1d295a8..44b7e61 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -863,11 +863,7 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
 	if (map->map_type != BPF_MAP_TYPE_SK_STORAGE)
 		goto put_map;

-	if (prog->aux->max_rdwr_access > map->value_size) {
-		err = -EACCES;
-		goto put_map;
-	}
-
+	aux->max_rdwr_access = bpf_map_raw_value_size(map);
 	aux->map = map;
 	return 0;

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 38df842..37144bf 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1951,11 +1951,7 @@ static int sock_map_iter_attach_target(struct bpf_prog *prog,
 	    map->map_type != BPF_MAP_TYPE_SOCKHASH)
 		goto put_map;

-	if (prog->aux->max_rdonly_access > map->key_size) {
-		err = -EACCES;
-		goto put_map;
-	}
-
+	aux->max_rdonly_access = map->key_size;
 	aux->map = map;
 	return 0;


> Fixes: 9db44fdd8105 ("bpf: Support kptrs in local storage maps")

Wrong tag. Iterators could write special fields from the start:
commit d6c4503cc296 ("bpf: Implement bpf iterator for hash maps") and
commit 5ce6e77c7edf ("bpf: Implement bpf iterator for sock local storage map").

[...]

> +	/* Fields are sorted by offset; max_rdwr_access is an exclusive end. */
> +	if (map->record && value_acc_size > map->record->fields[0].offset)

This will crash. map->record is an ERR_PTR when btf_parse_fields()
failed, and map_check_btf() still creates the map. A value with two
struct bpf_timer gets -E2BIG, for example. That's why other users check
IS_ERR_OR_NULL(). Attaching any iterator to such a map now faults on
fields[0], whether the prog touches the value or not. Same in
bpf_iter_sk_storage_map_check_prog().

Percpu maps don't have this bug. Their iterator runs on
percpu_value_buf: copy_map_value_long() skips special fields and
check_and_init_map_value() zeroes them, so the prog sees zeros and
writes to a temporary copy. This check rejects a prog that sums a
counter over all cpus in a percpu hash that has a kptr, for no reason.

It's an old bug, it needs root and the fix rejects progs that load
today. Pls target bpf-next.

pw-bot: cr
