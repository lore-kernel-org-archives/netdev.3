Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE653B7B6B
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147422; cv=none; b=MaU/Dyt3e+9Rh5MHidA7fJzgmu4OR6kTE5yrKLCIdh1qqLSuBgYl6/OLAUc85MYHp09ig0llQqgYQNgc63M0IJZkjq9pyPjjjtJy7Nv3eWrhKZ7RmIh5SnxMfn7kChdQ+t14bvkAH0KMYo91SPadF1zlbZ+pOJ4YSahSDED71VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147422; c=relaxed/simple;
	bh=B94fuPPQ1bnAoKm0lCdvRXcL2N2fserIpoovwFRRsyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k5ihWg0fHxIj5Sh92LbUTMBLrN7AZS274eznpYOeqhTnWbbbBdVvT6tDCnsuP7YHW2ztIQXi+PHClxjlHqw+XQEaJwYpfPJlp/JZmT4WVDMQ8/VRlN66AjDJK+4ydIeWhxOPbdtkugAZ43Z1LaBpbaJBpWu/LnvoHrPeiok/LOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXSndz7+; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXSndz7+"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-cbb818e57c9so398339a12.0
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 10:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789147420; x=1789752220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uZCf1M3wsJ6bfzqwhwc39vyj8+h7HAZ76J8nI4RK/4Y=;
        b=aXSndz7+1foYzW5RTbfH0VX6wr7jfr1DNHVUmlX94wILr5p3P7dDgqpXLHMLwPnwwa
         kPEByJY42qEItkwwRiSuLxygC1NDQjavgFsqrWr1YJAAm5D7AjAij4E5JOVPORTNH6pO
         orTpMdqdfywzSEJDMA/EkjLsLYcsCxuHoM6e6N8chu6Xp8FZAMAZhP57X5WDAKsswFKG
         yUd+61xitSTLp2UVMXBjgbBby5Gae0eIz8eiOG7aBj2sW6fakRhX06JjIgl7wllnyXX6
         EnWtoHs6gkg44PHaWOiAK4ozCSCe9Q2vIsA83ovsQLLC4K9qJRB//UE3/GL0bUI2DCRz
         aKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789147420; x=1789752220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uZCf1M3wsJ6bfzqwhwc39vyj8+h7HAZ76J8nI4RK/4Y=;
        b=RdR9AkmFbyhH+ooU0/B8NpdUqnr12SYbCUy2KMO38Kcpd29psie1oqTeSdP78PZNWa
         6KT85x/Dh95Czl8eKsdJa9vJ87z2KqHjrRFiL4nQfKw7AHWbonUZchFRyw1BGboXxs7O
         ba9+cQUWTc2uNCLbRuprDs1q/xpt+xCHrFZ3bNRU4rTfHs9y73asyDBNdzhveZwd8fiO
         q9qd7ZTBw/yaapaio1BOokFS9A7B1cCp9R0Hi7Rhy+Y637isFSP6Voxl1oC2s4HrTwqf
         D6gAoXOTOc+O7AtxuCiD1TGGLK3tX5+iSUfO+zipuQ06ouLv1+ZxP43yF4bTzT2TmRNb
         3wKA==
X-Gm-Message-State: AFuF++mEj9bfQh9UBdz2fdh8VUff68LfS3m1MlRCeKegISDDUC6CAcUx
	g2DqzhsvzbUoYCTkn2Y14XVutBTgPRI68fQCBY0EYH/WGv8HKC7TCbg04rdpKBIsvH9hAV9M3/U
	=
X-Gm-Gg: AYBFou15ND1rw+C4L9Xk1Zbw7Y7fPZLuwKX/HRea8jJmTa2ETAVEVfPRnyKkbrntqQ0
	Q7I7hNgFgjUfYAdbJEiZke27kzHB3I7betMPuKw7dzER/p7ePayXToGZQJJMw0+zuDoa5szOEtv
	qCjvKiEceo+p245VZM9b2yqZ1seMInJwI/TravwLi9d+6IXrGDI+FK/pteZix6n1h2oMcKQZMkO
	j44tXiEBhIpe8YbXQ7fqSw/6tX0Tj1xybAULaUVaUMwKAkmAaD2w7CuUv48pefzfZ+5h/mlFSby
	SBR9YpSJNxH4VYR9cly/eqJD4CeEXXfr0dTHcdQPKv08SEoMT0Hn0VGUozbY8F/OHhXjZhW9SrB
	106JH9pD7sM5cLAAXWOyTccvlzPg8cqJX+Wz5EMItAUW0fobiqoe46+O7I+MtpD0cHqHOPGRzoQ
	Zio8i0isX8nKScGg//vq2/gDddLf4j4XfgfR4VvV4lV1gyNhuaejw/tndx0OBnbEInByYBlIO1B
	k7v9kyj39fiJo0ytEeZe6IG3Q==
X-Received: by 2002:a05:6a00:6caa:b0:848:4754:28e4 with SMTP id d2e1a72fcca58-86b32aebb27mr8559815b3a.15.1789147419952;
        Fri, 11 Sep 2026 10:23:39 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b2a2b5c72sm1418774b3a.52.2026.09.11.10.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 10:23:39 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
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
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	akpm@linux-foundation.org,
	leon.hwang@linux.dev,
	yatsenko@meta.com,
	kpsingh@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	jordan@jrife.io,
	nhudson@akamai.com,
	avinash.duduskar@gmail.com,
	rongtao@cestc.cn,
	joe@wand.net.nz,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH bpf v2 1/2] bpf: reject incompatible socket assignments
Date: Sat, 12 Sep 2026 01:23:12 +0800
Message-ID: <20260911172313.64009-1-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_sk_assign() permits TC ingress programs to associate an IPv6 packet
with an AF_INET socket. The receive path can then interpret IPv6 skb
control data as IPv4 metadata. When IP_RETOPTS is enabled, this can cause
__ip_options_echo() to copy beyond its stack buffer.

Reject incompatible packet and socket families in bpf_sk_assign() and
bpf_sk_assign_tcp_reqsk(). Continue to allow IPv4 packets to use
dual-stack AF_INET6 sockets.

Check request sockets against rsk_ops->family, since their sk_family is
inherited from the listener and sk_ipv6only is not initialized.

Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
Assisted-by: LLM
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
Changes since v1:
- Move family validation out of the IPv6 receive fast path and into
  bpf_sk_assign() and bpf_sk_assign_tcp_reqsk().
- Preserve IPv4 assignments to dual-stack AF_INET6 sockets.
- Check request sockets using rsk_ops->family.
- Split the fix into two patches and target the BPF fixes tree.

v1:
https://lore.kernel.org/netdev/20260823101809.26802-1-shlomojune6@gmail.com/

 include/uapi/linux/bpf.h       |  4 ++++
 net/core/filter.c              | 31 +++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  4 ++++
 3 files changed, 39 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 732b35cc08d1c..5d8f5e2c8db38 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4568,6 +4568,10 @@ union bpf_attr {
  *		**-EOPNOTSUPP** if the operation is not supported, for example
  *		a call from outside of TC ingress.
  *
+ *		**-EAFNOSUPPORT** if the socket family is not compatible with
+ *		the network layer of the packet, for example an **AF_INET**
+ *		socket and an IPv6 packet.
+ *
  * long bpf_sk_assign(struct bpf_sk_lookup *ctx, struct bpf_sock *sk, u64 flags)
  *	Description
  *		Helper is overloaded depending on BPF program type. This
diff --git a/net/core/filter.c b/net/core/filter.c
index 61940e7535523..e9cc76b775c0c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3491,6 +3491,32 @@ static int bpf_skb_proto_xlat(struct sk_buff *skb, __be16 to_proto)
 	return -ENOTSUPP;
 }
 
+static bool bpf_sk_assign_family_ok(const struct sk_buff *skb,
+				    const struct sock *sk)
+{
+	unsigned short family;
+
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		family = AF_INET;
+		break;
+	case htons(ETH_P_IPV6):
+		family = AF_INET6;
+		break;
+	default:
+		return true;
+	}
+
+	/* Requests inherit the listener family, but have family-specific ops. */
+	if (sk->sk_state == TCP_NEW_SYN_RECV)
+		return inet_reqsk(sk)->rsk_ops->family == family;
+
+	return sk->sk_family == family ||
+	       (family == AF_INET &&
+		sk->sk_family == AF_INET6 &&
+		!ipv6_only_sock(sk));
+}
+
 BPF_CALL_3(bpf_skb_change_proto, struct sk_buff *, skb, __be16, proto,
 	   u64, flags)
 {
@@ -7989,6 +8015,8 @@ BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64, flags)
 		return -ENETUNREACH;
 	if (sk_unhashed(sk))
 		return -EOPNOTSUPP;
+	if (!bpf_sk_assign_family_ok(skb, sk))
+		return -EAFNOSUPPORT;
 	if (sk_is_refcounted(sk) &&
 	    unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
 		return -ENOENT;
@@ -12526,6 +12554,9 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
 	if (net != sock_net(sk))
 		return -ENETUNREACH;
 
+	if (!bpf_sk_assign_family_ok(skb, sk))
+		return -EAFNOSUPPORT;
+
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
 		ops = &tcp_request_sock_ops;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 732b35cc08d1c..5d8f5e2c8db38 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4568,6 +4568,10 @@ union bpf_attr {
  *		**-EOPNOTSUPP** if the operation is not supported, for example
  *		a call from outside of TC ingress.
  *
+ *		**-EAFNOSUPPORT** if the socket family is not compatible with
+ *		the network layer of the packet, for example an **AF_INET**
+ *		socket and an IPv6 packet.
+ *
  * long bpf_sk_assign(struct bpf_sk_lookup *ctx, struct bpf_sock *sk, u64 flags)
  *	Description
  *		Helper is overloaded depending on BPF program type. This
-- 
2.43.0
