Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158C235E549
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 21:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789335945; cv=pass; b=jA6iaRY5T//2JI4XVR4Nug4Ycv/u2ohnp1viM9VS0OF+JK6oeo1Y91szaMnxxYQqQ5TS0ADkQ0xE8eDTIde9Py4L1iAyt51h9JRa+Q2T2KwoizCJBuevjsL6SCblF/wuWBBwc4bGr1yDBggbHazGCfmNfxjBTPEKTFhvyjtmWNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789335945; c=relaxed/simple;
	bh=3ChVwPf7L6CbbcPpn7QTWmYjio4abm5vdU3U/Xy8aEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gXdRuDvKpheO0mRjeF6RQmVVSJw/gpLUZyY+kl/NAm5oBQQxEbqmotQREAP8TLa71v+nb8yGeIGFW4QPYDDiYProU48cfZScLUahIvzBBo/irpltSudfh6Cm/AGKChbI5QLrnFDSVwdCAcHix+umxgOm3/Q8P0Q5O+kxwIP6Z7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=VNr2ugLT; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="VNr2ugLT"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-869d181419bso2417907b3a.2
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 14:45:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789335942; cv=none;
        d=google.com; s=arc-20260327;
        b=QUGgi/KhcT03m322qlFPeUxya9JgEGsvYsXnJWPDZlyjrIrBupfhmw4CnsTAO25c1e
         M1qeb/uODpO3kLIuzJu1R2n7OimU42KS93R58M3kgtRfogPBo6WQ0pp9Z/sYdXGNtpE/
         KwRgDaV4zbLYC73ch4KbI24TzSaH8sB5S+DXKNrJNrn1nx/VL6HbN9l4fH3Yy3sRUjqV
         17G28CH1VL4aWKkdzFTNNmNd1zl9y1wd7pJYC8/XHY0PKAnVsHgu/zVgONiFwImNGw8N
         PTbH0oz7g3uu7EnF3uVrcoQ1mzlUQzk6cP7Jb2L47TZodHCVmYlnYJa1b41+y5AG3pZ8
         q+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6yFfwEnps0X+Vs2zYTErZ5+RZuq0vg4DZf/rN9/U95E=;
        fh=ExW1gjGVtoT5YAQvaPTUUkErYSsX9EPMGImzG7k0SZ8=;
        b=Ev7/bmpvPx++Txfi5lPGCLO7qnerzX6FlHqcOfPTJL0E0r10D+ONjxcQZ6aLqcMxBL
         Aza3xxKlKHk6iPKGLPfFXloSmTrM99AgQXxT+61pqYYVegiOMwMVuT6DbcT8qvmc5rYg
         N29kMnRgMeM7ml2FEdcLhkyyeUP8INfv+ZdRe3BmF58yluFFCS1Ly7EmYScSV8KzlEwS
         D6/JSU9rUPeII1+bwqXfLJ3EAGlzrUNWcIYlHQhXUYygqra3Aqq0ekr+Bsq8NxL8J/G4
         MP1FMf7JEwfyF9jjtbn89k/aHZXy2QL9mU5/+9QKrl6wZdz5Am5+ICSjRX2pT56STUq2
         dEUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789335942; x=1789940742; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6yFfwEnps0X+Vs2zYTErZ5+RZuq0vg4DZf/rN9/U95E=;
        b=VNr2ugLTc7DaUyy5GymhGEt11NGcw5XOaP0SokmrOMi6Va/MSsAGNSFp0TU/SF4Uwy
         rfzEicQFhhdNEyRFqphilDZDA5HZ05N+GfnEbN15EzGX3wHAQQtB7RKkZT5spj/c/jpU
         M89NdB8p6AM+xFID0ExDM5+Ku5LA5lUJUpzgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789335942; x=1789940742;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6yFfwEnps0X+Vs2zYTErZ5+RZuq0vg4DZf/rN9/U95E=;
        b=SYY49JeSSzsw2qgC98W/h2KH+ljwBpYzUhKEnI+xWoerozlWlSkpOR3R7PeEpr+EMT
         AhGFZFBBI+S9aTHKJCpVTtcvrDS87PiEmEcQns+X74+oxmbkzAq9Z8JS9CFlOtY40AYX
         0DQ/jkuxoVyndjJx9SKSqgItp1SRJifwfXOV+AigAvyPxnY0jbl43MBdv3NXfKRiQeOz
         eWg/jWUm363n9dV59jO54CQvQtQ2RPmHQQj72aZBVttLWCK8iXysKq610YgYVBHXxPm0
         7oMdIf9KEJ1k7KZ7mDM/Mld4O1rB5HXpk9j4vTa9WPFy8QgIkoXLmClTHPHzkRZJ7x1Y
         ZKlQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJvvoCZTZhHu/JrKC+c4JGWC75bSMfZ73egrC+fA1G6tymiYZ7HTX3MstZG0VybGcqOZfPy7o=@vger.kernel.org
X-Gm-Message-State: AFuF++mfQUM0XFBN3V1aMlsDNrpuEEo3/2pSj1rxnL6c6uFnQecNgvZF
	tEtzn9tEkqM2cw4v9682kiinKLEQHxVKNzjwuNf/Ay+qcDUWhEOcqN3W25zlJQjtLvQ+AFI7y34
	T9YQTncvEDAUS4LoskWV3rw9lpGzQ/jASYx52gC+L
X-Gm-Gg: AYBFou0LAg7gMKuN5NKD/ohrivcOVoF4dYyta5kV3Joj5cqlq8CDK/TnLQtD6wmOtOG
	U+zl0VOrsK7nlO/FhlE9RS3OT2L7pQyfDQocUtl+0MRr+V2R4ijDCjBB07o42/zXFGF9s52siFN
	0Z3fDQ8j3ut8oRM+VqeXjr4yapJVQl9KIaa+KtsnAjCXyggY599SPkqhzYRsmfnsvtG4V1wL44e
	mAED+qTCGC40GSNvUUfcaFhcosU1cVEVs3LFyuEbxO4LgshKYo/iwZtCSmLWrzxnX9oIX/rgJcz
	W2ALOoFajJW1WVHxAKpzXLsouxIsfPNzh/b38h2RVQ+Cg1R08GnaP6u4w76aPTuBT+ww45fb+Jw
	hRIOgQlak5fNM9abhaQZTxfTJhClDdvfuSw==
X-Received: by 2002:a05:6a00:ad8e:b0:848:30c3:45dd with SMTP id
 d2e1a72fcca58-86b3041253emr24971956b3a.11.1789335942089; Sun, 13 Sep 2026
 14:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2d4e79d252a57bdad83435999dddf2c4b708dcfa.1785049236.git.bronzed_45_vested@icloud.com>
 <20260731175022.18fd8744@kernel.org> <CAHYtud34rLPuGq6oSLem3VW8V+YrBBxdi+CRVbiQQZOrsRCOQA@mail.gmail.com>
 <20260804174508.20c0e505@kernel.org> <anmHJxrbKazL6_N8@mail.google.com>
In-Reply-To: <anmHJxrbKazL6_N8@mail.google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 13 Sep 2026 17:45:30 -0400
X-Gm-Features: AcwNN1UuXwQiG2pVH931vLMOPr2wt6vnsrLu3ZcHNaQj0WP_alnuT3XJt4MmQkw
Message-ID: <CAM0EoM=46m0=mu6sytmHZXE99Mfk_MQ37u9-z-t2FJHyoOPs7A@mail.gmail.com>
Subject: Re: [PATCH net v3] net: loopback: ensure Ethernet header is linear
 before eth_type_trans
To: Wyatt Feng <wf.kernel.dev@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Nebula Security <vega@nebusec.ai>, Ren Wei <enjou1224z@gmail.com>, 
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 5:11=E2=80=AFAM Wyatt Feng <wf.kernel.dev@gmail.com=
> wrote:
>
> This is Wyatt Feng, replying from a new address dedicated to kernel
> development, as my previous iCloud Hide My Email address does not
> support multiple recipients.
>
> On Tue, Aug 04, 2026 at 05:45:08PM -0800, Jakub Kicinski wrote:
> > Shouldn't TCA_VLAN_ACT_POP_ETH make sure another header is accessible
> > then? Are there other ways for something to strip L2 before the frame
> > reaches the driver?
>
> Making TCA_VLAN_ACT_POP_ETH verify that a full inner Ethernet header is
> accessible would prevent the original act_vlan path. However, that alone
> would not protect loopback_xmit(), because other paths can leave the skb
> without an Ethernet header before it reaches the driver.
>
> I found another path that can strip L2 before the skb reaches the driver:
> the IFE decode action. On egress, tcf_ife_decode() calls ife_decode(),
> which pulls the outer Ethernet header and the IFE metadata header. It the=
n
> calls eth_type_trans(), which consumes the inner Ethernet header. If the
> action returns TC_ACT_PIPE, the skb continues to the driver without an
> Ethernet header at skb->data.
>
> The reproducer below attaches IFE decode to the loopback egress path and
> sends a large, non-linear IFE frame through an AF_PACKET socket. After IF=
E
> decode returns, loopback_xmit() calls eth_type_trans() again and hits the
> skb assertion. This path does not use TCA_VLAN_ACT_POP_ETH.
> The IFE action is not present in the panic stack because it has already
> returned before the driver xmit function is invoked.
>
> Therefore, I think the check in loopback_xmit() is still needed as a
> defensive check at the common consumer.
>
> I reproduced this on:
>
>   7.2.0-rc6-00240-gdd057113a
>

Our system has vetted this issue as reproducible, with a caveat:
We took into account the feedback from Sashiko. Replace this line:

 if (unlikely(!pskb_may_pull(skb, ETH_HLEN))) {
with:
 if (unlikely(skb_headlen(skb) < ETH_HLEN)) {

Then retest and resend. I will add my ACK and tested-by

cheers,
jamal



> The test can be run in a disposable VM as follows. CONFIG_NET_ACT_IFE,
> CONFIG_NET_CLS_MATCHALL and CONFIG_NET_SCH_INGRESS are required.
>
>   gcc -O2 -Wall -Wextra -o ife_reproducer ife_reproducer.c
>   unshare -Urn sh
>   ip link set lo up
>   tc qdisc add dev lo clsact
>   tc filter add dev lo egress protocol 0xed3e pref 1 matchall \
>       action ife decode pipe
>   ./ife_reproducer lo
>
> ife_reproducer.c:
>
> #include <arpa/inet.h>
> #include <errno.h>
> #include <net/ethernet.h>
> #include <net/if.h>
> #include <netpacket/packet.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/socket.h>
> #include <unistd.h>
>
> #ifndef ETH_P_IFE
> #define ETH_P_IFE 0xED3E
> #endif
>
> #define IFE_META_HDR_LEN 2
> #define PAYLOAD_LEN 8192
>
> static void set_eth_header(unsigned char *data, const unsigned char *dst,
>                            const unsigned char *src, uint16_t proto)
> {
>         uint16_t be_proto =3D htons(proto);
>
>         memcpy(data, dst, ETH_ALEN);
>         memcpy(data + ETH_ALEN, src, ETH_ALEN);
>         memcpy(data + 2 * ETH_ALEN, &be_proto, sizeof(be_proto));
> }
>
> int main(int argc, char **argv)
> {
>         static const unsigned char outer_dst[ETH_ALEN] =3D
>                 { 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff };
>         static const unsigned char outer_src[ETH_ALEN] =3D
>                 { 0x11, 0x22, 0x33, 0x44, 0x55, 0x66 };
>         static const unsigned char inner_dst[ETH_ALEN] =3D
>                 { 0x02, 0x00, 0x00, 0x00, 0x00, 0x01 };
>         static const unsigned char inner_src[ETH_ALEN] =3D
>                 { 0x02, 0x00, 0x00, 0x00, 0x00, 0x02 };
>         const char *ifname =3D argc > 1 ? argv[1] : "lo";
>         const size_t inner_off =3D ETH_HLEN + IFE_META_HDR_LEN;
>         const size_t len =3D inner_off + ETH_HLEN + PAYLOAD_LEN;
>         struct sockaddr_ll sll =3D { 0 };
>         uint16_t meta_len;
>         unsigned char *frame;
>         ssize_t sent;
>         int fd =3D -1;
>         int ret =3D 1;
>
>         frame =3D malloc(len);
>         if (!frame) {
>                 perror("malloc");
>                 return 1;
>         }
>
>         memset(frame, 'A', len);
>         set_eth_header(frame, outer_dst, outer_src, ETH_P_IFE);
>
>         /* IFE metalen includes the two-byte IFE metadata header itself. =
*/
>         meta_len =3D htons(IFE_META_HDR_LEN);
>         memcpy(frame + ETH_HLEN, &meta_len, sizeof(meta_len));
>
>         set_eth_header(frame + inner_off, inner_dst, inner_src, ETH_P_IP)=
;
>
>         fd =3D socket(AF_PACKET, SOCK_RAW, htons(ETH_P_IFE));
>         if (fd < 0) {
>                 perror("socket");
>                 goto out;
>         }
>
>         sll.sll_family =3D AF_PACKET;
>         sll.sll_protocol =3D htons(ETH_P_IFE);
>         sll.sll_ifindex =3D if_nametoindex(ifname);
>         if (!sll.sll_ifindex) {
>                 fprintf(stderr, "unknown interface: %s\n", ifname);
>                 goto out;
>         }
>
>         if (bind(fd, (struct sockaddr *)&sll, sizeof(sll)) < 0) {
>                 perror("bind");
>                 goto out;
>         }
>
>         sent =3D send(fd, frame, len, 0);
>         if (sent < 0) {
>                 perror("send");
>                 goto out;
>         }
>         if ((size_t)sent !=3D len) {
>                 fprintf(stderr, "short send: %zd of %zu bytes\n", sent, l=
en);
>                 goto out;
>         }
>
>         printf("sent %zu-byte IFE frame on %s\n", len, ifname);
>         ret =3D 0;
>
> out:
>         if (fd >=3D 0)
>                 close(fd);
>         free(frame);
>         return ret;
> }
>
> The resulting panic was:
>
> [  300.362037][ T9401] kernel BUG at include/linux/skbuff.h:2847!
> [  300.362790][ T9401] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> [  300.364887][ T9401] Hardware name: Red Hat KVM, BIOS 1.16.0-4.module+e=
l8.9.0+1408+7b966129 04/01/2014
> [  300.365955][ T9401] RIP: 0010:eth_type_trans (include/linux/skbuff.h:2=
847 include/linux/skbuff.h:2854 i
> [  300.366668][ T9401] Code: 56 33 f8 44 89 73 70 be 0e 00 00 00 48 c7 c7=
 80 94 19 8d e8 e4 d8 0f f8 31 d2
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   56                      push   %rsi
>    1:   33 f8                   xor    %eax,%edi
>    3:   44 89 73 70             mov    %r14d,0x70(%rbx)
>    7:   be 0e 00 00 00          mov    $0xe,%esi
>    c:   48 c7 c7 80 94 19 8d    mov    $0xffffffff8d199480,%rdi
>   13:   e8 e4 d8 0f f8          callq  0xfffffffff80fd8fc
>   18:   31 d2                   xor    %edx,%edx
> [  300.368865][ T9401] RSP: 0018:ffa000000746f5d8 EFLAGS: 00010246
> [  300.369584][ T9401] RAX: 0000000000000000 RBX: ff110000388fa200 RCX: f=
fffffff89651ff5
> [  300.370504][ T9401] RDX: 0000000000000200 RSI: ff11000025560040 RDI: 0=
000000000000002
> [  300.371424][ T9401] RBP: 0000000000000020 R08: 0000000000000130 R09: 0=
000000000000000
> [  300.372342][ T9401] R10: ffe21c000d3248e9 R11: ff1100006992474b R12: f=
f110000220c1000
> [  300.373263][ T9401] R13: ff110000390b96e0 R14: 0000000000002000 R15: 0=
000000000000020
> [  300.374183][ T9401] FS:  00007f7566a8b540(0000) GS:ff110000d5379000(00=
00) knlGS:0000000000000000
> [  300.375217][ T9401] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  300.375987][ T9401] CR2: 0000000025b75000 CR3: 0000000038ea3000 CR4: 0=
000000000751ef0
> [  300.376902][ T9401] PKRU: 55555554
> [  300.377327][ T [118;1:3u9401] Call Trace:
> [  300.377725][ T9401]  <TASK>
> [  300.378091][ T9401]  loopback_xmit (include/linux/skbuff.h:3393 driver=
s/net/loopback.c:86)
> [  300.378672][ T9401]  ? srso_alias_return_thunk (arch/x86/lib/retpoline=
.S:234)
> [  300.379379][ T9401]  dev_hard_start_xmit (include/linux/netdevice.h:53=
97 include/linux/netdevice.h:5406
> [  300.380026][ T9401]  ? srso_alias_return_thunk (arch/x86/lib/retpoline=
.S:234)
> [  300.380724][ T9401]  __dev_queue_xmit (net/core/dev.c:4878)
> [  300.381370][ T9401]  ? srso_alias_return_thunk (arch/x86/lib/retpoline=
.S:234)
> [  300.382058][ T9401]  ? __lock_acquire (kernel/locking/lockdep.c:3820 k=
ernel/locking/lockdep.c:3876 kern
> [  300.382678][ T9401]  ? __pfx___dev_queue_xmit (include/linux/netdevice=
.h:4035)
> [  300.383351][ T9401]  ? srso_alias_return_thunk (arch/x86/lib/retpoline=
.S:234)
> [  300.384042][ T9401]  ? find_held_lock (kernel/locking/lockdep.c:5350)
> [  300.384643][ T9401]  ? __might_fault (mm/memory.c:7292 mm/memory.c:728=
6)
> [  300.385260][ T9401]  ? srso_alias_return_thunk (arch/x86/lib/retpoline=
.S:234)
> [  300.385958][ T9401]  ? __might_fault (mm/memory.c:7292 mm/memory.c:728=
6)
> [  300.386563][ T9401]  ? srso_alias_return_thunk (arch/x86/lib/retpoline=
.S:234)
> [  300.387254][ T9401]  ? write_comp_data (kernel/kcov.c:246)
> [  300.387875][ T9401]  ? srso_alias_return_thunk (arch/x86/lib/retpoline=
.S:234)
> [  300.388562][ T9401]  ? __sanitizer_cov_trace_pc (kernel/kcov.c:217)
> [  300.389260][ T9401]  ? srso_alias_return_thunk (arch/x86/lib/retpoline=
.S:234)
> [  300.389952][ T9401]  ? _copy_from_iter (include/linux/iov_iter.h:299 i=
nclude/linux/iov_iter.h:330 lib/i
> [  300.390597][ T9401]  ? srso_alias_return_thunk (arch/x86/lib/retpoline=
.S:234)
> [  300.391286][ T9401]  ? __sanitizer_cov_trace_pc (kernel/kcov.c:217)
> [  300.391979][ T9401]  ? srso_alias_return_thunk (arch/x86/lib/retpoline=
.S:234)
> [  300.392665][ T9401]  ? _copy_from_iter (include/linux/iov_iter.h:299 i=
nclude/linux/iov_iter.h:330 lib/i
> [  300.393308][ T9401]  ? __pfx__copy_from_iter (include/linux/iov_iter.h=
:157)
> [  300.393978][ T9401]  ? srso_alias_return_thunk (arch/x86/lib/retpoline=
.S:234)
> [  300.394665][ T9401]  ? __sanitizer_cov_trace_pc (kernel/kcov.c:217)
> [  300.395364][ T9401]  ? __pfx__copy_from_iter (include/linux/iov_iter.h=
:157)
> [  300.396031][ T9401]  ? srso_alias_return_thunk (arch/x86/lib/retpoline=
.S:234)
> [  300.396722][ T9401]  ? write_comp_data (kernel/kcov.c:246)
> [  300.397331][ T9401]  ? __sanitizer_cov_trace_pc (kernel/kcov.c:217)
> [  300.398026][ T9401]  ? srso_alias_return_thunk (arch/x86/lib/retpoline=
.S:234)
> [  300.398711][ T9401]  ? packet_parse_headers.isra.71 (include/linux/skb=
uff.h:3194 net/packet/af_packet.c
> [  300.399475][ T9401]  ? __pfx_packet_parse_headers.isra.71 (net/packet/=
af_packet.c:1550)
> [  300.400267][ T9401]  packet_xmit (include/linux/netdevice.h:3448 net/p=
acket/af_packet.c:276 net/packet/
> [  300.400848][ T9401]  ? write_comp_data (kernel/kcov.c:246)
> [  300.401460][ T9401]  packet_sendmsg (net/packet/af_packet.c:3104 net/p=
acket/af_packet.c:3136)
> [  300.402106][ T9401]  ? __pfx_avc_has_perm (security/selinux/avc.c:529)
> [  300.402755][ T9401]  ? srso_alias_return_thunk (arch/x86/lib/retpoline=
.S:234)
> [  300.403440][ T9401]  ? __sanitizer_cov_trace_pc (kernel/kcov.c:217)
> [  300.404137][ T9401]  ? __pfx_packet_sendmsg (net/packet/af_packet.c:25=
02)
> [  300.404798][ T9401]  ? __pfx_sock_has_perm (security/selinux/include/o=
bjsec.h:232)
> [  300.405419][ T9401]  ? srso_alias_return_thunk (arch/x86/lib/retpoline=
.S:234)
> [  300.406110][ T9401]  ? write_comp_data (kernel/kcov.c:246)
> [  300.406723][ T9401]  ? __entry_text_end (??:?)
> [  300.407390][ T9401]  ? __sanitizer_cov_trace_pc (kernel/kcov.c:217)
> [  300.408083][ T9401]  ? tomoyo_find_next_domain (security/tomoyo/domain=
.c:838 (discriminator 1))
> [  300.408789][ T9401]  ? __pfx_tomoyo_socket_sendmsg_permission (securit=
y/tomoyo/network.c:604)
> [  300.409615][ T9401]  ? release_sock (include/linux/spinlock.h:348 net/=
core/sock.c:3856)
> [  300.410218][ T9401]  ? srso_alias_return_thunk (arch/x86/lib/retpoline=
.S:234)
> [  300.410908][ T9401]  ? write_comp_data (kernel/kcov.c:246)
> [  300.411517][ T9401]  ? srso_alias_return_thunk (arch/x86/lib/retpoline=
.S:234)
> [  300.412209][ T9401]  ? selinux_socket_sendmsg (include/net/sock.h:2962=
 security/selinux/hooks.c:5284)
> [  300.412898][ T9401]  ? srso_alias_return_thunk (arch/x86/lib/retpoline=
.S:234)
> [  300.413585][ T9401]  ? write_comp_data (kernel/kcov.c:246)
> [  300.414196][ T9401]  ? srso_alias_return_thunk (arch/x86/lib/retpoline=
.S:234)
> [  300.414891][ T9401]  ? __sanitizer_cov_trace_pc (kernel/kcov.c:217)
> [  300.415583][ T9401]  ? __pfx_packet_sendmsg (net/packet/af_packet.c:25=
02)
> [  300.416244][ T9401]  __sock_sendmsg (net/socket.c:775 net/socket.c:790=
)
> [  300.416828][ T9401]  __sys_sendto (net/socket.c:2252)
> [  300.417406][ T9401]  ? __pfx___sys_sendto (net/socket.c:2206)
> [  300.418076][ T9401]  ? srso_alias_return_thunk (arch/x86/lib/retpoline=
.S:234)
> [  300.418776][ T9401]  ? srso_alias_return_thunk (arch/x86/lib/retpoline=
.S:234)
> [  300.419463][ T9401]  ? __sys_bind (include/linux/file.h:62)
> [  300.420032][ T9401]  ? __pfx___sys_bind (net/socket.c:1920)
> [  300.420640][ T9401]  ? srso_alias_return_thunk (arch/x86/lib/retpoline=
.S:234)
> [  300.421336][ T9401]  ? srso_alias_return_thunk (arch/x86/lib/retpoline=
.S:234)
> [  300.422026][ T9401]  ? __sanitizer_cov_trace_pc (kernel/kcov.c:217)
> [  300.422728][ T9401]  ? srso_alias_return_thunk (arch/x86/lib/retpoline=
.S:234)
> [  300.423413][ T9401]  ? fput_close_sync (fs/file_table.c:618)
> [  300.424038][ T9401]  ? __pfx_fput_close_sync (fs/file_table.c:479)
> [  300.424685][ T9401]  ? dnotify_flush (fs/notify/dnotify/dnotify.c:161)
> [  300.425279][ T9401]  __x64_sys_sendto (net/socket.c:2259 net/socket.c:=
2255 net/socket.c:2255)
> [  300.425887][ T9401]  ? srso_alias_return_thunk (arch/x86/lib/retpoline=
.S:234)
> [  300.426574][ T9401]  ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4=
472)
> [  300.427253][ T9401]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arc=
h/x86/entry/syscall_64.c:94)
> [  300.427820][ T9401]  ? exc_page_fault (arch/x86/mm/fault.c:1539)
> [  300.428434][ T9401]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/en=
try_64.S:121)
> [  300.429147][ T9401] RIP: 0033:0x7f75669b2eec
> [  300.429693][ T9401] Code: 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 41=
 89 ca 64 8b 04 25 18 00 00 00 85
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   89 02                   mov    %eax,(%rdx)
>    2:   48 c7 c0 ff ff ff ff    mov    $0xffffffffffffffff,%rax
>    9:   eb b8                   jmp    0xffffffffffffffc3
>    b:   0f 1f 00                nopl   (%rax)
>    e:   41 89 ca                mov    %ecx,%r10d
>   11:   64 8b 04 25 18 00 00    mov    %fs:0x18,%eax
>   18:   00
>   19:   85                      .byte 0x85
> [  300.431895][ T9401] RSP: 002b:00007ffe9d0f1428 EFLAGS: 00000246 ORIG_R=
AX: 000000000000002c
> [  300.432873][ T9401] RAX: ffffffffffffffda RBX: 0000000025b742a0 RCX: 0=
0007f75669b2eec
> [  300.433795][ T9401] RDX: 000000000000201e RSI: 0000000025b742a0 RDI: 0=
000000000000003
> [  300.434710][ T9401] RBP: 0000000000000003 R08: 0000000000000000 R09: 0=
000000000000000
> [  300.435634][ T9401] R10: 0000000000000000 R11: 0000000000000246 R12: 0=
0007ffe9d0f1f15
> [  300.436553][ T9401] R13: 0000000000000000 R14: 0000000000000000 R15: 0=
000000000000000
> [  300.437494][ T9401]  </TASK>
> [  300.437865][ T9401] Modules linked in:
> [  300.438455][ T9401] ---[ end trace 0000000000000000 ]---
> [  300.439102][ T9401] RIP: 0010:eth_type_trans (include/linux/skbuff.h:2=
847 include/linux/skbuff.h:2854 i
> [  300.439791][ T9401] Code: 56 33 f8 44 89 73 70 be 0e 00 00 00 48 c7 c7=
 80 94 19 8d e8 e4 d8 0f f8 31 d2
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   56                      push   %rsi
>    1:   33 f8                   xor    %eax,%edi
>    3:   44 89 73 70             mov    %r14d,0x70(%rbx)
>    7:   be 0e 00 00 00          mov    $0xe,%esi
>    c:   48 c7 c7 80 94 19 8d    mov    $0xffffffff8d199480,%rdi
>   13:   e8 e4 d8 0f f8          callq  0xfffffffff80fd8fc
>   18:   31 d2                   xor    %edx,%edx
>   1a:   48 89 de                mov    %rbx,%rsi
>   1d:   48 c7 c7 c0 94 19 8d    mov    $0xffffffff8d1994c0,%rdi
>   24:   e8 43 b3 d5 ff          callq  0xffffffffffd5b36c
>   29:   90                      nop
>   2a:*  0f 0b                   ud2             <-- trapping instruction
>   2c:   bd 00 01 00 00          mov    $0x100,%ebp
>   31:   e9 1e ff ff ff          jmpq   0xffffffffffffff54
>   36:   48 8b 7c 24 20          mov    0x20(%rsp),%rdi
>   3b:   e8 3c d4 a8 f8          callq  0xfffffffff8a8d47c
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   0f 0b                   ud2
>    2:   bd 00 01 00 00          mov    $0x100,%ebp
>    7:   e9 1e ff ff ff          jmpq   0xffffffffffffff2a
>    c:   48 8b 7c 24 20          mov    0x20(%rsp),%rdi
>   11:   e8 3c d4 a8 f8          callq  0xfffffffff8a8d452
> [  300.442007][ T9401] RSP: 0018:ffa000000746f5d8 EFLAGS: 00010246
> [  300.442738][ T9401] RAX: 0000000000000000 RBX: ff110000388fa200 RCX: f=
fffffff89651ff5
> [  300.443658][ T9401] RDX: 0000000000000200 RSI: ff11000025560040 RDI: 0=
000000000000002
> [  300.444599][ T9401] RBP: 0000000000000020 R08: 0000000000000130 R09: 0=
000000000000000
> [  300.445521][ T9401] R10: ffe21c000d3248e9 R11: ff1100006992474b R12: f=
f110000220c1000
> [  300.446460][ T9401] R13: ff110000390b96e0 R14: 0000000000002000 R15: 0=
000000000000020
> [  300.447413][ T9401] FS:  00007f7566a8b540(0000) GS:ff110000d5379000(00=
00) knlGS:0000000000000000
> [  300.448711][ T9401] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  300.449508][ T9401] CR2: 0000000025b75000 CR3: 0000000038ea3000 CR4: 0=
000000000751ef0
> [  300.450443][ T9401] PKRU: 55555554
> [  300.450878][ T9401] Kernel panic - not syncing: Fatal exception in int=
errupt
>
