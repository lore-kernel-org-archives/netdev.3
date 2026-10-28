Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793220228;
	b=TZj1juI6SqQC3n0UmJI3U/EF3XGsPEdizJ3udQe8+MZVsqmQBw/hvqJk5kdgeFZ6mpgr
	 6M2YdiIgXS1/8z16vgqkZVqHWFffZF2hGdkCbz1iYiTTcOgnxTmnkVQcrQe7Jn27uZCHj
	 555JaWhac5O/f+1o9Mk6NcT9PFu77WH03f0pLexfg4+vb5b5S8NAih822iPmwe1hPDzbv
	 aLK0YwSMrmBBYyZuCbhtl8xczWyUnU3IUChp3RDuTeEOWVhgjX6IqdnmZT3qT9qaEYWXL
	 Wl4+IMH0SAaLFOqNlamQFA6imPu5p2wah7zdjp+/Ej0PEAbEXx8E+yO+51deJ9NLHCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793220228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=sYFizRDYH2l5PRAThPlhmp5H+wdA+bi9uDiPY3FNe8A=;
	b=Y+EBhfYjbAdJwKb/vlSBbwAs2BJy4Oh6z3hkarGE1EQl/Rh5y/KfLjy4lmbcdNYZ2W6L
	 BZMbswCeo7TmFl/iIBNV8JSQ558VGvZPFWKUUWws+IdklHcMJ9vM1vDpI7rBhMaTY3KQN
	 DnQ163LjRF/8e3kA30B5u/zyDi93naU4Xf+d0bA8x9pyzxOnHa9aHv33DafkyDRKyb6iK
	 WCEAkaqy/HJK4bngYzhbhuYaZ1bEhlAErmdWaqRCSuf3D88eVbP1F/tXF4UXm62cIh2+j
	 Mla9wfmWfeb8BD8SnANSwxznipiCqqddcIbLJcfY8H9kkJjJTAOqCIO3h6wndD0DPwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EP5zDEZu;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8977A606A31E
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 20:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8977A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EP5zDEZu
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ae6fda7a00so135967a91.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 13:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793220228; x=1793825028; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sYFizRDYH2l5PRAThPlhmp5H+wdA+bi9uDiPY3FNe8A=;
        b=EP5zDEZuhAKrdNdd28vLWL8Jqs/tGjkjFdj3ctBUEeZ2mIX6dffOxQnztyE7kVnNj0
         Gkv1c0etxKo0qvupD9Tpjx1PNrBQHGAdP8pd9eiyKpLTdMp90F3Fk1xYRQ8VummfNVeC
         cAZlLQmYrM0qxuWI/8zD2eJBMXMak6iLXHKYDmLJMtAoRKasfxC0lquFxbwDu5KMKXSv
         qQEodINp0LedvjR4TUo2wecaxPnVT0YoC8yISFAjd/+CcQLznmplY9bKWq6kz4EECww1
         yPNgelTjXpeOR7jUlvM1nmhNBv0NLrK+6mP7oWXOZYDzbunVwoVah68dy4cn3Jt3t4iK
         LWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793220228; x=1793825028;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sYFizRDYH2l5PRAThPlhmp5H+wdA+bi9uDiPY3FNe8A=;
        b=X9tdeNe5/p4sYR3mhDsgI9DWSiw2PI3+4y32tcrOYN5xT7Qn122p1HYF8EFUahpcXS
         Vt/EWjcOyvmCfbTePSZXl971p+ECo9JR9eXwO5tPFQkaXOlNSqeavtQP3lun4Rjiy4bE
         qmLEAYp5IojgrZOxgKb5rH/GYN7tpZ5/qYZIhLxwg7X8dFx5Eph/y9gYpwdfIvRe6kNL
         Druw/voCI0AZpQ1EUYyZXfuNmBidW/4bHOLJB7/Y/s5HEwcBa/l3jeHB0/RClWver7z9
         MMi70V3fWhx0MWLBQfPcOFsDO8FjyCpOCiu2FuGyuRdvtQQ4fdmT2Ph6kgsk+Xs9JLY6
         I2pQ==
X-Gm-Message-State: AFq9FYKtc+S9GSEw7qDJIpMHIM4FtSTkyUQDUMnjNmvJs7aZyTxLiWtq
	U1ujZiUwb53qZ94fARv+6RD8nsh5tzFF5QQ25SSRh7VJ7yd3jjiCrlpMzYfMHD74vc6KtLn9w6C
	d+le81A==
X-Received: from pjro24.prod.google.com ([2002:a17:90a:b898:b0:3ac:c43b:e322])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:548f:b0:3ad:3e8:12
 with SMTP id 98e67ed59e1d1-3ae581ba9acmr2022196a91.48.1793220227735; Wed, 28
 Oct 2026 13:43:47 -0700 (PDT)
Date: Wed, 28 Oct 2026 20:43:47 +0000
In-Reply-To: <20261028173533.2658096-3-rjethwani@purestorage.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028173533.2658096-1-rjethwani@purestorage.com> <20261028173533.2658096-3-rjethwani@purestorage.com>
Message-ID: <auJd9BMr16dafOhE@google.com>
Subject: Re: [PATCH net v3 2/2] selftests: tls: test that TLS and KCM are
 mutually exclusive
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Shuah Khan <shuah@kernel.org>, Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, 28 Oct 2026 11:35:33 -0600, Rishikesh Jethwani wrote:
> Cover both orders, with TLS RX and TLS TX on the attach side, and check
> that a socket detached from KCM with SIOCKCMUNATTACH can still be
> upgraded to TLS.

I don't think we want a test.

This will just waste testing budgets unless someone tries
to restore the combination, which is unlikely to happen.


> 
> KCM needs a BPF parser program, so the tests are skipped without
> AF_KCM or when the program can't be loaded. Add CONFIG_AF_KCM to the
> net selftest config.
> 
> Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
> ---
>  tools/testing/selftests/net/config |   1 +
>  tools/testing/selftests/net/tls.c  | 144 +++++++++++++++++++++++++++++
>  2 files changed, 145 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
> index cb8cb4696df7..1619478fffc4 100644
> --- a/tools/testing/selftests/net/config
> +++ b/tools/testing/selftests/net/config
> @@ -1,3 +1,4 @@
> +CONFIG_AF_KCM=m
>  CONFIG_AMT=m
>  CONFIG_BAREUDP=m
>  CONFIG_BONDING=m
> diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
> index 9d3cd4fff062..2e4128e0676a 100644
> --- a/tools/testing/selftests/net/tls.c
> +++ b/tools/testing/selftests/net/tls.c
> @@ -7,19 +7,24 @@
>  #include <error.h>
>  #include <fcntl.h>
>  #include <poll.h>
> +#include <stddef.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
>  
> +#include <linux/bpf.h>
> +#include <linux/kcm.h>
>  #include <linux/tls.h>
>  #include <linux/tcp.h>
>  #include <linux/socket.h>
>  
>  #include <sys/epoll.h>
> +#include <sys/ioctl.h>
>  #include <sys/types.h>
>  #include <sys/sendfile.h>
>  #include <sys/socket.h>
>  #include <sys/stat.h>
> +#include <sys/syscall.h>
>  
>  #include "kselftest_harness.h"
>  
> @@ -3492,6 +3497,145 @@ TEST(data_steal) {
>  	close(cfd);
>  }
>  
> +#ifndef AF_KCM
> +#define AF_KCM 41
> +#endif
> +
> +/* KCM and TLS are mutually exclusive, in either order. */
> +FIXTURE(kcm)
> +{
> +	int fd, cfd, kcm, bpf;
> +};
> +
> +FIXTURE_SETUP(kcm)
> +{
> +	/* KCM parser: each message is everything queued (skb->len) */
> +	struct bpf_insn insns[] = {
> +		{ .code = BPF_LDX | BPF_MEM | BPF_W, .dst_reg = BPF_REG_0,
> +		  .src_reg = BPF_REG_1,
> +		  .off = offsetof(struct __sk_buff, len) },
> +		{ .code = BPF_JMP | BPF_EXIT },
> +	};
> +	union bpf_attr attr = {};
> +	struct sockaddr_in addr;
> +	socklen_t len;
> +	int sfd, ret;
> +
> +	self->fd = -1;
> +	self->cfd = -1;
> +	self->bpf = -1;
> +
> +	self->kcm = socket(AF_KCM, SOCK_DGRAM, KCMPROTO_CONNECTED);
> +	if (self->kcm < 0)
> +		SKIP(return, "no KCM support");
> +
> +	attr.prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
> +	attr.insns = (unsigned long)insns;
> +	attr.insn_cnt = ARRAY_SIZE(insns);
> +	attr.license = (unsigned long)"GPL";
> +	self->bpf = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
> +	if (self->bpf < 0)
> +		SKIP(return, "can't load KCM parser BPF program");
> +
> +	len = sizeof(addr);
> +	addr.sin_family = AF_INET;
> +	addr.sin_addr.s_addr = htonl(INADDR_ANY);
> +	addr.sin_port = 0;
> +
> +	self->fd = socket(AF_INET, SOCK_STREAM, 0);
> +	sfd = socket(AF_INET, SOCK_STREAM, 0);
> +
> +	ret = bind(sfd, &addr, sizeof(addr));
> +	ASSERT_EQ(ret, 0);
> +	ret = listen(sfd, 10);
> +	ASSERT_EQ(ret, 0);
> +	ret = getsockname(sfd, &addr, &len);
> +	ASSERT_EQ(ret, 0);
> +	ret = connect(self->fd, &addr, sizeof(addr));
> +	ASSERT_EQ(ret, 0);
> +	self->cfd = accept(sfd, &addr, &len);
> +	ASSERT_GE(self->cfd, 0);
> +
> +	close(sfd);
> +}
> +
> +FIXTURE_TEARDOWN(kcm)
> +{
> +	close(self->kcm);
> +	close(self->bpf);
> +	close(self->fd);
> +	close(self->cfd);
> +}
> +
> +static int kcm_attach(struct _test_data_kcm *self)
> +{
> +	struct kcm_attach attach = { .fd = self->cfd, .bpf_fd = self->bpf };
> +
> +	return ioctl(self->kcm, SIOCKCMATTACH, &attach);
> +}
> +
> +static int kcm_unattach(struct _test_data_kcm *self)
> +{
> +	struct kcm_unattach unattach = { .fd = self->cfd };
> +
> +	return ioctl(self->kcm, SIOCKCMUNATTACH, &unattach);
> +}
> +
> +static void kcm_tls_then_attach(struct __test_metadata *_metadata,
> +				struct _test_data_kcm *self, int optname)
> +{
> +	struct tls_crypto_info_keys tls;
> +	int ret;
> +
> +	ret = setsockopt(self->cfd, IPPROTO_TCP, TCP_ULP, "tls", sizeof("tls"));
> +	if (ret && errno == ENOENT)
> +		SKIP(return, "no TLS support");
> +	ASSERT_EQ(ret, 0);
> +
> +	tls_crypto_info_init(TLS_1_2_VERSION, TLS_CIPHER_AES_GCM_128, &tls, 0);
> +	ret = setsockopt(self->cfd, SOL_TLS, optname, &tls, tls.len);
> +	ASSERT_EQ(ret, 0);
> +
> +	EXPECT_EQ(kcm_attach(self), -1);
> +	EXPECT_EQ(errno, EOPNOTSUPP);
> +}
> +
> +TEST_F(kcm, tls_rx_then_attach)
> +{
> +	kcm_tls_then_attach(_metadata, self, TLS_RX);
> +}
> +
> +TEST_F(kcm, tls_tx_then_attach)
> +{
> +	kcm_tls_then_attach(_metadata, self, TLS_TX);
> +}
> +
> +TEST_F(kcm, attach_then_tls)
> +{
> +	int ret;
> +
> +	ASSERT_EQ(kcm_attach(self), 0);
> +
> +	ret = setsockopt(self->cfd, IPPROTO_TCP, TCP_ULP, "tls", sizeof("tls"));
> +	if (ret && errno == ENOENT)
> +		SKIP(return, "no TLS support");
> +	EXPECT_EQ(ret, -1);
> +	EXPECT_EQ(errno, EINVAL);
> +}
> +
> +TEST_F(kcm, tls_after_unattach)
> +{
> +	int ret;
> +
> +	ASSERT_EQ(kcm_attach(self), 0);
> +	ASSERT_EQ(kcm_unattach(self), 0);
> +
> +	ret = setsockopt(self->cfd, IPPROTO_TCP, TCP_ULP, "tls", sizeof("tls"));
> +	if (ret && errno == ENOENT)
> +		SKIP(return, "no TLS support");
> +	EXPECT_EQ(ret, 0);
> +}
> +
>  static void __attribute__((constructor)) fips_check(void) {
>  	int res;
>  	FILE *f;
> -- 
> 2.50.1
> 
