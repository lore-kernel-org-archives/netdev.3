Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AD24DC552
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 17:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616174; cv=pass; b=ifm7aekLsqGmYbqRzz4m3V+q0jXwxzi1pum/J+P9rtRxHf3gT2yry/z4j4YICihT1KVv+b9DTPyK+LEO8qDM1q97/gHjOXQEFAl8w1MfKx3uOadP/VtlpfvtGJs40Iy5VGNX/9qkLBi31g2Y1ZKnDIyYQOzvY8byG2Q1JIIFe1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616174; c=relaxed/simple;
	bh=hho2DMUpWsCY94xeZA0WNwM6ZCUGWXA30U/4H8Oc2g8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQ8mVPIk8aljXx96Qlxbe2FKfK8vYvvtYz6qFBVsNyBkLy80MEYU+dnajA8vmjnPqTiNFo9618Ur9L2fuVp5c7ZItjLyU23B/j6L0uuvOijGb6qiMUVM5YB7RVA/lyKkgp+Fjp+Laz6KObsgT5ZgiaxYIYUGf6wKf0hyiHkiy5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UpQ1omuD; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UpQ1omuD"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53113d72966so21781cf.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 10:22:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790616155; cv=none;
        d=google.com; s=arc-20260327;
        b=msHSVfk7j7viLbeTHsZFS1OarAv6PMiS8Ih6k+LIt80STCDeqtTOSVIgx4ic2QrFsI
         FYhfwpD3iP8bDojuuzR2FdXn35lINIkS/IwjZ2ZMgcNhPYSKOjdWdf48HPuKuvkVhy9f
         1DiJP8rjr+wcJqCwDDXQRTdOBOn8DSoACpsLzX8qtK1Dqo7YVcI+rpObmG7zmkXl99L/
         2yRIHZjLQrdbgUhmaMMGwX/KXlhm36hiEO31EzowFw9WU2iuF/RS0vr3RrzjtatWFmoc
         MEx9sFhKaVrP8aAW+qFWPBTMq5qHqhZCXtt71J4iEMXk/CpDjxGhxTj/NqU1+ohekjo1
         61HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qn9IeVcamjlplvoMpkZXwtHnEFuRf27DcvOtQjuI+0g=;
        fh=t1JtxbnAM1tVaTFILQ2972n+ptBUxcJw7wR0rLOZz7c=;
        b=spMg+rD7uVqHLm5qAKeJk6y5jE3XIwq2Tk0QloMwUdtECMfHZByK86nmRcssEpZlFA
         npiEzRkrhhH1cdHEFji5v6RFwlhqlM2KV5V02GNAg9q+8MGrJjIHljDaIsCx3Bsn4AeR
         4wGClr7b6VU37sbY/DHPVuX/JUGdaNGxiDxgZeZmWrXxXymGX43lD5hTJY+GZKnQO2Ed
         5Sa64hx+NAkYNhUeub/cAN4S2qIMYyTGVNpxXfZgh/5UFdYrMa9CjvYgPRhmMvaj/ma2
         IJKsQnoSSqCqAecHSD9drIG0CD+U2mWo4rHBC5eBAFPsceFetpFJn8Yzon4LGcFx3wk6
         0+aQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790616155; x=1791220955; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qn9IeVcamjlplvoMpkZXwtHnEFuRf27DcvOtQjuI+0g=;
        b=UpQ1omuD86LCfhQd2ahnkKNLIJc/Q7TRmqVYfWu3VFAHjfkizD6/slcxhl8xUCQ2kE
         DdTWJb0LYjgTRnttHwHDaq4Q7i+MuYW+lphbGJmEmfXaBs0tRcpefX/pCwdDLGX+dMuw
         QpKS0VWFQVw/xVmiuewZwALGnH/Hnz9KBU5n3Oqt+UgsAkMsoVbCTAFZcoeuC0xniZYh
         9/RFfwer8u/zy7L9cTCgKExXjeIo2Z8ra9x7mcMjC1zm+e/2szWQhOSvXl+rgBGXelO+
         XXT7kNh9gJiS8DEkBEHISAe1zO9eAkCph6xyT74JY5fE8AMp259jFjihlwbxhGVouPfD
         MBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790616155; x=1791220955;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qn9IeVcamjlplvoMpkZXwtHnEFuRf27DcvOtQjuI+0g=;
        b=zy06cL6DxQNac4IBPQb89CDocaQx1+pePWcoZ7/aEyeXETTg1zQ5x/gaLkk0hI33oc
         2vE5fpKthOMGAq9XkIQHbUmMRVwifZNA5bwG71YdEN6NST9+F9gfpdlKxX6Pxgzg+j3q
         mtxBwfnm/rA3D50lX+abE5x5GJx9S7OZLnuQkHymbmHsFYfsqQRrshgEHOL7zCtH9bl6
         H/jQ1a3AtcENLyttlY1Fvraqm7EAT8xrAY9uyHotT121iQI5F25jEYaZxmVHsSXLDpn/
         qlwYv8c2+tiYD2/v8DPCBlF/WIuJX0Ok2OvEoGV0fkS7dk622NbaPENPZWhZsvJbH7Vr
         Y7hw==
X-Forwarded-Encrypted: i=1; AKwUvByMpLg94pUIWUudWrem417qQHzX7YUDvnG4OGShbtzlbGU4qXYwWKrpVhMc29Ss4cli5bl8+XY=@vger.kernel.org
X-Gm-Message-State: AFuF++l1N2MfmA/IvxJ+zRKZyVrPsQL7yKUq7S50zFjcx5ZIf+EZE4XK
	ub8R61+mSrjzT6moHLwu9szz4TJFayqz5p4CsB/7/ON4m1szElMMw13d2CynFYNEOwZC1OJItrX
	KNXceGyvoNDtYzILTDGBH1paFWcCU+pg2wz9Gj87E
X-Gm-Gg: AYBFou0i8+mWJmIBwqSIEaWGGPsellnj9u44zXd9xHmOpcd/n/PhjMS8iWa1lRl/I/W
	yM/tGP5VOCNeqT+98US/BkDnPWjjVDaLMbnKvhGVI3Y58xX2R4QtWsYR0WDW55H5l7/xvSBHYlO
	CfcDTh0yciEHIZEGRDcS6wA3xD0WBMlhIFvCChf/aHVotSd/O7SOAIkHaGrG0zbNWFCj3hwD7mc
	TOhsnbzFqJYBPb5UgGhccy+UC6tGL9/RUTth6JST8g6Sp+ROK26QdSWKv30KupbYa2OPH+Ju4C7
	sI2uIfBGS6fgExwqy5wrgNL+3hhgKvV3pwilL1qOmwAeEylVPeT3m26IX+dCF/cAfkvETilyuje
	tnOCCPCtT0w==
X-Received: by 2002:a05:622a:1926:b0:532:c99e:b16b with SMTP id
 d75a77b69052e-533225e5f2amr33109861cf.3.1790616153702; Mon, 28 Sep 2026
 10:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925135244.3715196-1-edumazet@google.com> <20260925135244.3715196-3-edumazet@google.com>
In-Reply-To: <20260925135244.3715196-3-edumazet@google.com>
From: Wei Wang <weiwan@google.com>
Date: Mon, 28 Sep 2026 10:22:22 -0700
X-Gm-Features: AclHuK_hWWo0-foeHHvQGXzz24jxKsNaWFzlJ_qnigZMv9pPffpWe_WNhqdBiMM
Message-ID: <CAEA6p_A4Rgk81_=b+osGxV-0PmcBDkP2H98=+bgp74jraVNueQ@mail.gmail.com>
Subject: Re: [PATCH v2 net 2/2] selftests/net: add SO_RESERVE_MEM test
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Cai Xinchen <caixinchen1@huawei.com>, netdev@vger.kernel.org, edumazet@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 6:52=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Add a kselftest suite covering SO_RESERVE_MEM behavior:
> - Reject unsupported socket types (UDP/SOCK_DGRAM, UNIX/SOCK_STREAM,
>   SOCK_RAW, MPTCP) with EOPNOTSUPP.
> - Validate bounds (negative values and values > SZ_1G return EINVAL).
> - Verify reserve adjustments (increase, decrease, page rounding, and
>   reset to 0) and corresponding sk_meminfo[SK_MEMINFO_FWD_ALLOC] changes
>   via getsockopt(SO_MEMINFO).
> - Exercise cgroup v2 memory.max enforcement returning ENOMEM when the
>   requested reservation exceeds the cgroup limit.
> - Verify that a child socket returned by accept() starts with a 0
>   reserve even when its parent listener configured a non-zero
>   SO_RESERVE_MEM.
> - Verify reserve retention across TCP send/receive/ACK cycles.
>
> Also enable CONFIG_CGROUPS=3Dy and CONFIG_MEMCG=3Dy in
> tools/testing/selftests/net/config.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Assisted-by: LLM
> ---
>  tools/testing/selftests/net/.gitignore       |   1 +
>  tools/testing/selftests/net/Makefile         |   1 +
>  tools/testing/selftests/net/config           |   2 +
>  tools/testing/selftests/net/so_reserve_mem.c | 404 +++++++++++++++++++
>  4 files changed, 408 insertions(+)
>  create mode 100644 tools/testing/selftests/net/so_reserve_mem.c
>
> diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selft=
ests/net/.gitignore
> index c9f46031ac73b20850d068125bb804420d236ad8..a15d7cc4fdcb22b36fdb35b9e=
af47e511caa8673 100644
> --- a/tools/testing/selftests/net/.gitignore
> +++ b/tools/testing/selftests/net/.gitignore
> @@ -41,6 +41,7 @@ skf_net_off
>  socket
>  so_incoming_cpu
>  so_netns_cookie
> +so_reserve_mem
>  so_rcv_listener
>  stress_reuseport_listen
>  tap
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftes=
ts/net/Makefile
> index 3ee3378f8b26eff9d99a834491ad5ef594dcd782..300207a840c1bcb73a41151c8=
f94e8f78d01a29b 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -196,6 +196,7 @@ TEST_GEN_PROGS :=3D \
>         sk_connect_zero_addr \
>         sk_so_peek_off \
>         so_incoming_cpu \
> +       so_reserve_mem \
>         tap \
>         tcp_port_share \
>         tls \
> diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests=
/net/config
> index 737e7e6327b3793984718eb518d3fb79b7870e4d..d355cf98059770bbcdcda1a33=
d8e84bc390eb26a 100644
> --- a/tools/testing/selftests/net/config
> +++ b/tools/testing/selftests/net/config
> @@ -7,6 +7,7 @@ CONFIG_BRIDGE_VLAN_FILTERING=3Dy
>  CONFIG_CAN=3Dm
>  CONFIG_CAN_DEV=3Dm
>  CONFIG_CAN_VXCAN=3Dm
> +CONFIG_CGROUPS=3Dy
>  CONFIG_CRYPTO_ARIA=3Dy
>  CONFIG_CRYPTO_CHACHA20POLY1305=3Dm
>  CONFIG_CRYPTO_SHA1=3Dy
> @@ -61,6 +62,7 @@ CONFIG_L2TP_V3=3Dy
>  CONFIG_MACSEC=3Dm
>  CONFIG_MACVLAN=3Dy
>  CONFIG_MACVTAP=3Dy
> +CONFIG_MEMCG=3Dy
>  CONFIG_MPLS=3Dy
>  CONFIG_MPLS_IPTUNNEL=3Dm
>  CONFIG_MPLS_ROUTING=3Dm
> diff --git a/tools/testing/selftests/net/so_reserve_mem.c b/tools/testing=
/selftests/net/so_reserve_mem.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..920aeccc0ddf780e1b7ffd217=
2cf8bc2a01320f1
> --- /dev/null
> +++ b/tools/testing/selftests/net/so_reserve_mem.c
> @@ -0,0 +1,404 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <limits.h>
> +#include <linux/sock_diag.h>
> +#include <netinet/in.h>
> +#include <sched.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mount.h>
> +#include <sys/socket.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +
> +#include "kselftest_harness.h"
> +
> +#ifndef IPPROTO_MPTCP
> +#define IPPROTO_MPTCP 262
> +#endif
> +

Should we add
#ifndef SO_RESERVE_MEM
#define SO_RESERVE_MEM 73
#endif
for systems which don't have SO_RESERVE_MEM defined?

> +#define SO_RESERVE_MEM_MAX (1 << 30)
> +
> +static int get_reserve_mem(struct __test_metadata *_metadata, int fd)
> +{
> +       int val =3D -1;
> +       socklen_t len =3D sizeof(val);
> +
> +       EXPECT_EQ(getsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, &len),=
 0);
> +       return val;
> +}
> +
> +static __u32 get_fwd_alloc(struct __test_metadata *_metadata, int fd)
> +{
> +       __u32 meminfo[SK_MEMINFO_VARS] =3D {};
> +       socklen_t len =3D sizeof(meminfo);
> +
> +       EXPECT_EQ(getsockopt(fd, SOL_SOCKET, SO_MEMINFO, meminfo, &len), =
0);
> +       return meminfo[SK_MEMINFO_FWD_ALLOC];
> +}
> +
> +static void wait_wmem_drained(struct __test_metadata *_metadata, int fd)
> +{
> +       __u32 meminfo[SK_MEMINFO_VARS] =3D {};
> +       socklen_t len;
> +       int i;
> +
> +       for (i =3D 0; i < 1000; i++) {
> +               len =3D sizeof(meminfo);
> +               ASSERT_EQ(getsockopt(fd, SOL_SOCKET, SO_MEMINFO, meminfo,=
 &len), 0);
> +               if (meminfo[SK_MEMINFO_WMEM_QUEUED] =3D=3D 0)
> +                       return;
> +               usleep(1000);
> +       }
> +       EXPECT_EQ(meminfo[SK_MEMINFO_WMEM_QUEUED], 0U);
> +}
> +
> +FIXTURE(so_reserve_mem)
> +{
> +       char cg_root[64];
> +       char cg_child[128];
> +       long page_size;
> +       bool cg_mounted;
> +       bool restore_subtree_ctrl;
> +};
> +
> +FIXTURE_TEARDOWN(so_reserve_mem)
> +{
> +       char path[160];
> +       int fd;
> +
> +       if (!self->cg_mounted)
> +               return;
> +
> +       snprintf(path, sizeof(path), "%s/cgroup.procs", self->cg_root);
> +       fd =3D open(path, O_WRONLY);
> +       if (fd >=3D 0) {
> +               dprintf(fd, "%d\n", getpid());
> +               close(fd);
> +       }
> +       if (self->cg_child[0]) {
> +               rmdir(self->cg_child);
> +               self->cg_child[0] =3D '\0';
> +       }
> +       if (self->restore_subtree_ctrl) {
> +               snprintf(path, sizeof(path), "%s/cgroup.subtree_control",
> +                        self->cg_root);
> +               fd =3D open(path, O_WRONLY);
> +               if (fd >=3D 0) {
> +                       if (write(fd, "-memory", 7) < 0)
> +                               ;
> +                       close(fd);
> +               }
> +               self->restore_subtree_ctrl =3D false;
> +       }
> +       umount2(self->cg_root, MNT_DETACH);
> +       rmdir(self->cg_root);
> +       self->cg_mounted =3D false;
> +}
> +
> +FIXTURE_SETUP(so_reserve_mem)
> +{
> +       char procs_path[160], ctrl_path[160], ctrl_buf[256] =3D {};
> +       int fd, ret, val =3D 0;
> +
> +       self->page_size =3D sysconf(_SC_PAGESIZE);
> +       ASSERT_GT(self->page_size, 0);
> +
> +       if (unshare(CLONE_NEWNS))
> +               SKIP(return, "Failed to unshare mount namespace (need roo=
t)");
> +
> +       mount("none", "/", NULL, MS_REC | MS_PRIVATE, NULL);
> +
> +       snprintf(self->cg_root, sizeof(self->cg_root),
> +                "/tmp/ksft_so_reserve_XXXXXX");
> +       ASSERT_NE(mkdtemp(self->cg_root), NULL);
> +
> +       if (mount("none", self->cg_root, "cgroup2", 0, NULL)) {
> +               rmdir(self->cg_root);
> +               SKIP(return, "Failed to mount cgroup2 (need root)");
> +       }
> +       self->cg_mounted =3D true;
> +
> +       snprintf(ctrl_path, sizeof(ctrl_path), "%s/cgroup.subtree_control=
",
> +                self->cg_root);
> +       fd =3D open(ctrl_path, O_RDWR);
> +       if (fd < 0) {
> +               so_reserve_mem_teardown(_metadata, self, variant);
> +               SKIP(return, "Failed to open cgroup.subtree_control");
> +       }
> +       if (read(fd, ctrl_buf, sizeof(ctrl_buf) - 1) < 0) {
> +               close(fd);
> +               so_reserve_mem_teardown(_metadata, self, variant);
> +               SKIP(return, "Failed to read cgroup.subtree_control");
> +       }
> +       if (!strstr(ctrl_buf, "memory")) {
> +               if (write(fd, "+memory", 7) !=3D 7) {
> +                       close(fd);
> +                       so_reserve_mem_teardown(_metadata, self, variant)=
;
> +                       SKIP(return, "cgroup2 memory controller not avail=
able");
> +               }
> +               self->restore_subtree_ctrl =3D true;
> +       }
> +       close(fd);
> +
> +       snprintf(self->cg_child, sizeof(self->cg_child), "%s/test_%d",
> +                self->cg_root, getpid());
> +       if (mkdir(self->cg_child, 0755)) {
> +               self->cg_child[0] =3D '\0';
> +               so_reserve_mem_teardown(_metadata, self, variant);
> +               ASSERT_TRUE(false);
> +       }
> +
> +       snprintf(procs_path, sizeof(procs_path), "%s/cgroup.procs",
> +                self->cg_child);
> +       fd =3D open(procs_path, O_WRONLY);
> +       if (fd < 0 || dprintf(fd, "%d\n", getpid()) <=3D 0) {
> +               if (fd >=3D 0)
> +                       close(fd);
> +               so_reserve_mem_teardown(_metadata, self, variant);
> +               ASSERT_TRUE(false);
> +       }
> +       close(fd);
> +
> +       /* Verify memcg socket accounting is enabled on this kernel */
> +       fd =3D socket(AF_INET, SOCK_STREAM, 0);
> +       if (fd < 0) {
> +               so_reserve_mem_teardown(_metadata, self, variant);
> +               ASSERT_GE(fd, 0);
> +       }
> +       ret =3D setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof(v=
al));
> +       close(fd);
> +       if (ret && errno =3D=3D EOPNOTSUPP) {
> +               so_reserve_mem_teardown(_metadata, self, variant);
> +               SKIP(return, "memcg socket accounting not enabled");
> +       }
> +       if (ret) {
> +               so_reserve_mem_teardown(_metadata, self, variant);
> +               ASSERT_EQ(ret, 0);
> +       }
> +}
> +
> +static void check_non_tcp_rejected(struct __test_metadata *_metadata,
> +                                  int domain, int type, int protocol,
> +                                  int val)
> +{
> +       int fd =3D socket(domain, type, protocol);
> +
> +       if (fd < 0) {
> +               EXPECT_TRUE(errno =3D=3D EAFNOSUPPORT ||
> +                           errno =3D=3D EPROTONOSUPPORT ||
> +                           errno =3D=3D ENOPROTOOPT);
> +               return;
> +       }
> +       EXPECT_EQ(setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof=
(val)), -1);
> +       EXPECT_EQ(errno, EOPNOTSUPP);
> +       close(fd);
> +}
> +
> +TEST_F(so_reserve_mem, non_tcp_rejected)
> +{
> +       int val =3D self->page_size * 4;
> +
> +       check_non_tcp_rejected(_metadata, AF_INET, SOCK_DGRAM, 0, val);
> +       check_non_tcp_rejected(_metadata, AF_UNIX, SOCK_STREAM, 0, val);
> +       check_non_tcp_rejected(_metadata, AF_INET, SOCK_RAW, IPPROTO_ICMP=
, val);
> +       check_non_tcp_rejected(_metadata, AF_INET, SOCK_STREAM, IPPROTO_M=
PTCP, val);

Add a test for check_non_tcp_rejected(_metadata, AF_INET, SOCK_DGRAM,
0, 0) to validate that non-TCP socket with val =3D 0 also returns
-EOPNOTSUPP rather than 0?

> +}
> +
> +TEST_F(so_reserve_mem, grow_shrink_and_rounding)
> +{
> +       int ps =3D self->page_size;
> +       int fd, val;
> +
> +       fd =3D socket(AF_INET, SOCK_STREAM, 0);
> +       ASSERT_GE(fd, 0);
> +
> +       EXPECT_EQ(get_reserve_mem(_metadata, fd), 0);
> +       EXPECT_EQ(get_fwd_alloc(_metadata, fd), 0U);
> +
> +       /* Negative or > SO_RESERVE_MEM_MAX value -> EINVAL */
> +       val =3D -1;
> +       EXPECT_EQ(setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof=
(val)), -1);
> +       EXPECT_EQ(errno, EINVAL);
> +
> +       val =3D SO_RESERVE_MEM_MAX + 1;
> +       EXPECT_EQ(setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof=
(val)), -1);
> +       EXPECT_EQ(errno, EINVAL);
> +
> +       val =3D INT_MAX;
> +       EXPECT_EQ(setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof=
(val)), -1);
> +       EXPECT_EQ(errno, EINVAL);
> +
> +       /* 1 byte rounds up to 1 page */
> +       val =3D 1;
> +       ASSERT_EQ(setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof=
(val)), 0);
> +       EXPECT_EQ(get_reserve_mem(_metadata, fd), ps);
> +       EXPECT_EQ(get_fwd_alloc(_metadata, fd), (__u32)ps);
> +
> +       /* Grow to 16 pages */
> +       val =3D 16 * ps;
> +       ASSERT_EQ(setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof=
(val)), 0);
> +       EXPECT_EQ(get_reserve_mem(_metadata, fd), 16 * ps);
> +       EXPECT_EQ(get_fwd_alloc(_metadata, fd), (__u32)(16 * ps));
> +
> +       /* Shrink by 1 byte (rounds delta down to 0 -> stays 16 pages) */
> +       val =3D 16 * ps - 1;
> +       ASSERT_EQ(setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof=
(val)), 0);
> +       EXPECT_EQ(get_reserve_mem(_metadata, fd), 16 * ps);
> +       EXPECT_EQ(get_fwd_alloc(_metadata, fd), (__u32)(16 * ps));
> +
> +       /* Shrink to 4 pages */
> +       val =3D 4 * ps;
> +       ASSERT_EQ(setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof=
(val)), 0);
> +       EXPECT_EQ(get_reserve_mem(_metadata, fd), 4 * ps);
> +       EXPECT_EQ(get_fwd_alloc(_metadata, fd), (__u32)(4 * ps));
> +
> +       /* Release all */
> +       val =3D 0;
> +       ASSERT_EQ(setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof=
(val)), 0);
> +       EXPECT_EQ(get_reserve_mem(_metadata, fd), 0);
> +       EXPECT_EQ(get_fwd_alloc(_metadata, fd), 0U);
> +
> +       close(fd);
> +}
> +
> +TEST_F(so_reserve_mem, cgroup_memory_max)
> +{
> +       char max_path[160], procs_path[160];
> +       int fd, max_fd, procs_fd, val;
> +       int ps =3D self->page_size;
> +
> +       snprintf(max_path, sizeof(max_path), "%s/memory.max", self->cg_ch=
ild);
> +       max_fd =3D open(max_path, O_WRONLY | O_NONBLOCK);
> +       if (max_fd < 0)
> +               SKIP(return, "cgroup memory controller not delegated");
> +
> +       fd =3D socket(AF_INET, SOCK_STREAM, 0);
> +       ASSERT_GE(fd, 0);
> +
> +       /* Move test process back to root cgroup before lowering cg_child=
's
> +        * memory.max so the limit only governs the socket's memcg charge=
s
> +        * and cannot trigger OOM on the test process itself.
> +        */
> +       snprintf(procs_path, sizeof(procs_path), "%s/cgroup.procs",
> +                self->cg_root);
> +       procs_fd =3D open(procs_path, O_WRONLY);
> +       ASSERT_GE(procs_fd, 0);
> +       ASSERT_GT(dprintf(procs_fd, "%d\n", getpid()), 0);
> +       close(procs_fd);
> +
> +       /* Limit cg_child memory to 8 pages and try to reserve 128 pages =
*/
> +       ASSERT_GT(dprintf(max_fd, "%ld\n", 8L * ps), 0);
> +
> +       val =3D 128 * ps;
> +       EXPECT_EQ(setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof=
(val)), -1);
> +       EXPECT_EQ(errno, ENOMEM);
> +       EXPECT_EQ(get_reserve_mem(_metadata, fd), 0);
> +
> +       /* Restore unlimited memory.max */
> +       ASSERT_GT(dprintf(max_fd, "max\n"), 0);
> +       close(max_fd);
> +
> +       val =3D 4 * ps;
> +       ASSERT_EQ(setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof=
(val)), 0);
> +       EXPECT_EQ(get_reserve_mem(_metadata, fd), 4 * ps);
> +
> +       close(fd);
> +}
> +
> +TEST_F(so_reserve_mem, accept_child_zero_reserve)
> +{
> +       struct sockaddr_in addr =3D {
> +               .sin_family =3D AF_INET,
> +               .sin_addr.s_addr =3D htonl(INADDR_LOOPBACK),
> +       };
> +       socklen_t alen =3D sizeof(addr);
> +       int ps =3D self->page_size;
> +       int lfd, cfd, sfd, val;
> +
> +       lfd =3D socket(AF_INET, SOCK_STREAM, 0);
> +       ASSERT_GE(lfd, 0);
> +
> +       /* Set SO_RESERVE_MEM on listener before listen() */
> +       val =3D 4 * ps;
> +       ASSERT_EQ(setsockopt(lfd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeo=
f(val)), 0);
> +       ASSERT_EQ(bind(lfd, (struct sockaddr *)&addr, sizeof(addr)), 0);
> +       ASSERT_EQ(listen(lfd, 2), 0);
> +       ASSERT_EQ(getsockname(lfd, (struct sockaddr *)&addr, &alen), 0);
> +
> +       /* Grow SO_RESERVE_MEM on listener after listen() */
> +       val =3D 8 * ps;
> +       ASSERT_EQ(setsockopt(lfd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeo=
f(val)), 0);
> +       EXPECT_EQ(get_reserve_mem(_metadata, lfd), 8 * ps);
> +       EXPECT_EQ(get_fwd_alloc(_metadata, lfd), (__u32)(8 * ps));
> +
> +       cfd =3D socket(AF_INET, SOCK_STREAM, 0);
> +       ASSERT_GE(cfd, 0);
> +       ASSERT_EQ(connect(cfd, (struct sockaddr *)&addr, sizeof(addr)), 0=
);
> +
> +       sfd =3D accept(lfd, NULL, NULL);
> +       ASSERT_GE(sfd, 0);
> +
> +       /* Child after accept() must have 0 reserve while listener keeps =
8 pages */
> +       EXPECT_EQ(get_reserve_mem(_metadata, sfd), 0);
> +       EXPECT_EQ(get_fwd_alloc(_metadata, sfd), 0U);
> +       EXPECT_EQ(get_reserve_mem(_metadata, lfd), 8 * ps);
> +       EXPECT_EQ(get_fwd_alloc(_metadata, lfd), (__u32)(8 * ps));
> +
> +       /* Child can still independently set its own SO_RESERVE_MEM */
> +       val =3D 6 * ps;
> +       ASSERT_EQ(setsockopt(sfd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeo=
f(val)), 0);
> +       EXPECT_EQ(get_reserve_mem(_metadata, sfd), 6 * ps);
> +       EXPECT_EQ(get_fwd_alloc(_metadata, sfd), (__u32)(6 * ps));
> +
> +       close(sfd);
> +       close(cfd);
> +       close(lfd);
> +}
> +
> +TEST_F(so_reserve_mem, preserved_after_traffic)
> +{
> +       struct sockaddr_in addr =3D {
> +               .sin_family =3D AF_INET,
> +               .sin_addr.s_addr =3D htonl(INADDR_LOOPBACK),
> +       };
> +       socklen_t alen =3D sizeof(addr);
> +       int ps =3D self->page_size;
> +       int lfd, cfd, sfd, val;
> +       char buf[8192] =3D {};
> +
> +       lfd =3D socket(AF_INET, SOCK_STREAM, 0);
> +       ASSERT_GE(lfd, 0);
> +       ASSERT_EQ(bind(lfd, (struct sockaddr *)&addr, sizeof(addr)), 0);
> +       ASSERT_EQ(listen(lfd, 1), 0);
> +       ASSERT_EQ(getsockname(lfd, (struct sockaddr *)&addr, &alen), 0);
> +
> +       cfd =3D socket(AF_INET, SOCK_STREAM, 0);
> +       ASSERT_GE(cfd, 0);
> +       val =3D 16 * ps;
> +       ASSERT_EQ(setsockopt(cfd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeo=
f(val)), 0);
> +       ASSERT_EQ(connect(cfd, (struct sockaddr *)&addr, sizeof(addr)), 0=
);
> +
> +       sfd =3D accept(lfd, NULL, NULL);
> +       ASSERT_GE(sfd, 0);
> +
> +       /* Send & drain traffic; cfd must retain its 16-page forward allo=
c,
> +        * while sfd (0 reserve) reclaims its forward alloc back to 0.
> +        */
> +       ASSERT_EQ(send(cfd, buf, sizeof(buf), 0), (ssize_t)sizeof(buf));
> +       ASSERT_EQ(recv(sfd, buf, sizeof(buf), MSG_WAITALL), (ssize_t)size=
of(buf));
> +       wait_wmem_drained(_metadata, cfd);
> +
> +       EXPECT_GE(get_fwd_alloc(_metadata, cfd), (__u32)(16 * ps));
> +       EXPECT_EQ(get_fwd_alloc(_metadata, sfd), 0U);
> +
> +       close(sfd);
> +       close(cfd);
> +       close(lfd);
> +}
> +
> +TEST_HARNESS_MAIN
> --
> 2.56.0.rc1.315.gc6ed9934b7-goog
>
