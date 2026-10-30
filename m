Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361723;
	b=CNu1a62kHfbV1UoIaZzYDNNPf2R861eeHJOJJ9eKbpe+Cap583dj0m9ljmsuqM0bQMV/
	 AkSVQYIMPGX0r3YDIafJgMox08dpCO2sRLlOpaUUQ9mx/9AO2BWRxYWuBb3Tfe8HLRS2a
	 001B2dCEzvF7MhbIXnrjSaYpE+jvs4wcn7/X+fLmrZqwc6+BrNsik8q33bRwgyvcpD9fq
	 c3nhJTb1w2IAb/m53dBHgSq+RXzUUaHeygr7tqZPiNYH8yOpCFrt8VaM96WpwwaQnjPRg
	 pSTC/Rk4hAgw63Hc+AzidkpfgRZPCqP9/9bSsB94eUwbQ+kOKOdn5sytgCGO2K0sg6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=vMwZvawBiyShXBewO3K0dol5CkgA9oaHML9/XArfQDg=;
	b=a/pGQbD4lE1939f1hFsN8laytKkxAa7ePEfuvkLigIbajjZGEiFBIhmWE2Gct0z+r5ZV
	 tHiyBhBVTYUHh5Nf30FZRhlNuCVOuYIRCWtiZoJvTsM508fhP9geN+waBQ56j2DHkltOx
	 LMhPhFmyM0zFc1RAi+WFgGMeH/2YzrNCrshKFAzCJB/MduRIIGVRgrRH7Gtdx/ZQcMvfk
	 qQDSnDfDL4HoRtNTO4lM0SNZX/5SnG3mP0UKSk6T9myM4q/gw87dE1m1o4UCNZb7g5qKv
	 9MwuXIDP005/iyXWM8HTurw0g5JvsFQ4Hj3vmo68KR66IzvdZYFFnStr7WcCX6BXd5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=DRxY3OwX;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6372606A32C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 12:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6372606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=DRxY3OwX
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b488586facso716953a12.2
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 05:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793361721; x=1793966521; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vMwZvawBiyShXBewO3K0dol5CkgA9oaHML9/XArfQDg=;
        b=DRxY3OwXyfaaiay0YSbG0mi9ZjocAY7e59ETPcDqTJFexFmVR2lXQqKR1VbYP9xEpm
         jUNkn42kY5kiOzOxzdNHJfD3fc7MK2RV3wye1GWo/pdXpFVDQXDDadBsixZESzVKhvUj
         yC1AkEKyPgz2zGXRS1V8XXMh3jWvtTJrlQ+SSTbZQEzM3k2aFegAdLhtzpycKsKoJrSn
         iu7QUx3jD137RUZihYWV2ze3vTJqdedewn4+LC/Ib3Nr+gFTOILmTP7HSDiF3GZXdXO6
         EnyiZfYPUL/mO+IZHukqIRMWZGU4Xjuh/s1z5g5QgBO+RaKrIIHn2L/WAAVlnVuwVwkU
         TQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361721; x=1793966521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vMwZvawBiyShXBewO3K0dol5CkgA9oaHML9/XArfQDg=;
        b=mc3zlTrRhFug0pEZyZ4hdHWhkhzRD4OWO/fj7jeUgntH9W9MSwRwstuowFZrNc0QG9
         VHZgvwrMRPn+fIWE9z7/Fa0jP5HcS8wLMV5sjEgRNYBFAlf2OQcaWwAQnWD38a8CwTlC
         NoTkNv9WiWayA78H0+a1qKoVrX/mgQnlAHj7JhZrKorVpGrxdbB5ro5DO2tpjvY/+10w
         IxfXeYmP4h/cf2+BpkcZSemyXIp0/jpOIK6iDt2ug1KFncLUsuHi5s8kuqqe2uzmkeam
         ZzghDIco53OQX1kqjb3pRDh1cr3zgj8bm3wwj22QPlyIwG/3w0l2ttkQy0mIwXDoZCpR
         Y8cA==
X-Forwarded-Encrypted: i=1; AKwUvBxUhM4I58AMc7nSafOrB5ezGNohf80+T6Q09ZpNjrarYakQ20e1UNY/I4bVNGFJUphcoao3NoM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvl4AudMWLE4PErqa7VXR/BPLrBLC+MobIn9Vs9sGEu71MyKu+
	+8ezOes7eNQU2uot29N78PyIg9ZK1j5Y9O95qXyF0tnMXArThzstcTKD7t8/JX6CeA4=
X-Gm-Gg: AYBFou28NNVvCaPGf4rEXKc+kO9hmuIu5KzCAGEy88W4a/+sNx1bTGskLbGvvykdTgW
	pVHK5BCsrTry52IyR5q1rkmXrFeB4LjeL/PNG8g+4WCt9Sq/FQsFdRKaS/3YuWtd3RGEdYEU3CN
	og+jOhLt/4y6ks2B4axpWZt6SpHo80MtajWrO8ADnwWkabOs515cmijHY4hx7YW8L3dSSa3sRsa
	NSTEg+iQjdNaoTHAm+j/0SPKPUalQJ+v4KBWBK7Wa31rdQAMtQRGKkxKJlFQ/3pa8gfBtk0JKZl
	UBWo2FO64frxhX83r7UksDWZnE/uHZjntBoTTsNqTIh4ychLIYBX3IoDuW/BwpiEWgRnYxNjvog
	9oJ/UhjPwnj3/ExAwjRLBYA4LaTYQci1A7wg7imIm1y1j6MjdHvQhA85RRyEAgEqMXlVIlkVFZ4
	bzTOVpw0uJPW++IeCytHo1R8DZ6Xihon8fqhp1r7bjDTmkPGVhHv7osVqmzjdKH3lHvXYcW1TXK
	D1SWFVscVbQQ3sgo1oDiCiMY6Q8qg3Kvavs8CbXqn6VQjr5p66Tu7DudwbZL9wZ3gdhAkT+DkOo
	cpxG3UwSSyCX8Z4mxHC2JGjRdumM1m1WdIhFlg==
X-Received: by 2002:aa7:cd5c:0:b0:6b1:b5ea:2580 with SMTP id 4fb4d7f45d1cf-6b4d66a3ee6mr991534a12.44.1793361721111;
        Fri, 30 Oct 2026 05:02:01 -0700 (PDT)
Received: from cloudflare.com ([2a01:110f:491b:1300:7cff:6795:2d76:e9de])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4d7b1c592sm548135a12.25.2026.10.30.05.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:01:59 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 30 Oct 2026 13:01:53 +0100
Subject: [PATCH bpf-next 1/2] selftests/bpf: Cover concurrent sockmap
 update and delete
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-bpf-next-v1-1-035eabf8eae7@cloudflare.com>
References: <20261030-bpf-next-v1-0-035eabf8eae7@cloudflare.com>
In-Reply-To: <20261030-bpf-next-v1-0-035eabf8eae7@cloudflare.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.16.0

Add a sockmap_listen subtest where one thread keeps inserting a TCP
socket into a sockmap with an attached verdict program while another
thread deletes the same map entry.

Without any synchronization between the insert and delete paths, both
end up racing on psock teardown and the socket's proto callbacks,
which KCSAN reports as:

    ==================================================================
    BUG: KCSAN: data-race in sock_map_link / tcp_bpf_update_proto

    write (marked) to 0xffff88810b1f42a8 of 8 bytes by task 198 on cpu 0:
     tcp_bpf_update_proto+0x278/0x400
     sock_map_unref+0x1d3/0x240
     sock_map_delete_elem+0x7b/0xb0
     map_delete_elem+0x1e1/0x270
     __sys_bpf+0x71a/0x870
     __x64_sys_bpf+0x69/0x80
     x64_sys_call+0xf26/0x2550
     do_syscall_64+0xb8/0x2f0
     entry_SYSCALL_64_after_hwframe+0x76/0x7e

    read to 0xffff88810b1f42a8 of 8 bytes by task 194 on cpu 3:
     sock_map_link+0x146/0x5b0
     sock_map_update_common+0x74/0x2b0
     sock_map_update_elem_sys+0x246/0x2d0
     bpf_map_update_value+0x80/0x400
     map_update_elem+0x35c/0x3e0
     __sys_bpf+0x540/0x870
     __x64_sys_bpf+0x69/0x80
     x64_sys_call+0xf26/0x2550
     do_syscall_64+0xb8/0x2f0
     entry_SYSCALL_64_after_hwframe+0x76/0x7e

    value changed: 0xffffffff857540c0 -> 0xffffffff8468fde8

    Reported by Kernel Concurrency Sanitizer on:
    CPU: 3 UID: 0 PID: 194 Comm: test_progs Tainted: G           OE        7.3.0+ #12 PREEMPT(full)
    Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
    ==================================================================

Deleting an entry that is already gone is expected: sockmap reports
EINVAL and sockhash reports ENOENT. Re-inserting a socket whose psock
still holds the verdict program from a concurrent delete fails with
EBUSY. Tolerate these errnos; the test relies on KCSAN as the witness.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 235e1d56f044..dca1f0de92e0 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -646,6 +646,82 @@ static void test_race_insert_listen(struct test_sockmap_listen *skel __always_un
 	xclose(s);
 }
 
+struct update_delete_ctx {
+	unsigned int nr_iter;
+	unsigned int done;
+	int mapfd;
+};
+
+static void *delete_elem_thread(void *arg)
+{
+	struct update_delete_ctx *ctx = arg;
+	unsigned int i;
+
+	for (i = 0; i < ctx->nr_iter; i++) {
+		/* Expecting EINVAL (sockmap) or ENOENT (sockhash) when the
+		 * entry is already gone.
+		 */
+		if (bpf_map_delete_elem(ctx->mapfd, &(u32){0}) &&
+		    errno != EINVAL && errno != ENOENT) {
+			FAIL_ERRNO("map_delete");
+			break;
+		}
+	}
+
+	WRITE_ONCE(ctx->done, 1);
+	return NULL;
+}
+
+/* One thread keeps inserting a socket into a sockmap with an attached
+ * verdict program while another thread deletes the same map entry.
+ */
+static void test_update_delete_with_prog(struct test_sockmap_listen *skel,
+					 int family, int sotype, int mapfd)
+{
+	struct update_delete_ctx ctx = { 0 };
+	int err, s, verdict;
+	pthread_t t;
+	u64 value;
+
+	verdict = bpf_program__fd(skel->progs.prog_skb_verdict);
+	err = xbpf_prog_attach(verdict, mapfd, BPF_SK_SKB_VERDICT, 0);
+	if (err)
+		return;
+
+	s = xsocket(family, sotype, 0);
+	if (s < 0)
+		goto detach;
+
+	err = xlisten(s, 1);
+	if (err)
+		goto close;
+
+	ctx.mapfd = mapfd;
+	ctx.nr_iter = 10000;
+
+	err = xpthread_create(&t, NULL, delete_elem_thread, &ctx);
+	if (err)
+		goto close;
+
+	value = s;
+	while (!READ_ONCE(ctx.done)) {
+		/* Expecting EBUSY while a deleted socket's psock still
+		 * holds the verdict program.
+		 */
+		err = bpf_map_update_elem(mapfd, &(u32){0}, &value, BPF_ANY);
+		if (err && errno != EBUSY) {
+			FAIL_ERRNO("map_update");
+			break;
+		}
+	}
+
+	xpthread_join(t, NULL);
+close:
+	xclose(s);
+detach:
+	xbpf_prog_detach2(verdict, mapfd, BPF_SK_SKB_VERDICT);
+}
+
 static void zero_verdict_count(int mapfd)
 {
 	unsigned int zero = 0;
@@ -1289,6 +1365,7 @@ static void test_ops(struct test_sockmap_listen *skel, struct bpf_map *map,
 		TEST(test_destroy_orphan_child, SOCK_STREAM),
 		TEST(test_syn_recv_insert_delete, SOCK_STREAM),
 		TEST(test_race_insert_listen, SOCK_STREAM),
+		TEST(test_update_delete_with_prog, SOCK_STREAM),
 		/* child clone */
 		TEST(test_clone_after_delete, SOCK_STREAM),
 		TEST(test_accept_after_delete, SOCK_STREAM),

-- 
2.43.0

