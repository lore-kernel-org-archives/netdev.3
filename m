Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CB53F23BE
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 07:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787126119; cv=pass; b=XTAsk71XxPNsTqBnSFgwRu0mrGXtlRveB9NM171bRie/PezOKe2lHM32hdaU6iSzluiynQtbPsO2eiqqEoo4C7AzvErymLQVhyeBYQGmUC7U5scLmhB9b1rlodiHDA+4PyWWJoPR6a3Ry+IObBSbOCc3NWT+ZP9jMC0mCQQOeg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787126119; c=relaxed/simple;
	bh=DhtrX2h5AwpSmXYAz2ilrcLD4hNqnstbiVM2oGQHPe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0JavEi1/b9ndY+Jg9FHwzeqk/IJYUvuaLGc07d+Iee9PbBllDPA1okrhylIVRP6Jep02KPID9eNra+ikiXkzzq1pcb3gx/zHz0JqVr1/pEJLO1dOhiTVqccYI+qQzI6IPO4/ATCVTqayzUHNgY8N8K1PT2KeUD6EL7B+YuC6EA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LkAyhNEF; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LkAyhNEF"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-52d8748cde5so3623011cf.0
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 00:55:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787126117; cv=none;
        d=google.com; s=arc-20260327;
        b=pm4LIcHHYze+qQZXc9gsalla9/SD/NjRODJE/3MG8fgs5sAGn+N1NhHXO9kcOeOaMv
         yFdpL1TPUP6JmTepRVNB72DZgxO3/B6OolRiEMpQQ+BUS5pWQeNdslqkrduea41GHjgp
         WrF3nqyZ/Rr89PGBlbO24xKJ245IvOOPkl9ji2bzCXorCq8x1w6NCfrvd6has1kuxPD/
         Czkpv1NN+r7xRFyXsnYBUcrOwHsj5UnU3Gr9NLaeI5NTivDUN1AQCUUf4jQu+RgrdwMB
         f+F3IMA7lOr+TLbbOufrF5bvExOuYPoAcQ40jwJxEa+ufEFxhX+TTPUxWAIy79nnqRWL
         NqSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z0jE3gzT9/KW+Ch7bTrTGuJUus0VXch6kYVBXgjVeNE=;
        fh=kDvgL9+lWBwbB8ZjabOWtyDHHS+D5IR9WnH2fveP+OM=;
        b=gxYr/lzK1iZPARnNs7eTEckquQaTANxP+eS4QjZfFwtfjF65Uas4ak7Dm6dALb4aQ8
         cROnl8dTNr+gug8ipgs9zgwVmBZxVCGWyZG2MUmDDpUIB02WlwL3NdnlujcTxNxqnXue
         3Wn+IxIMXIeISBKlW4jZoOSQD6lSsub7sFmr4L4CcfGJS5QHOl0HkqckpwBAaeKuVWou
         XtdyXtu/sCxWRtFROu5K5uXFcpggNYeluo2Nzp+L/zHLbHFQhNKkyFyTdNoXlcFs3ald
         qdU9DQTzYauirEYq4X3e/wIWu/72NgKQpambC1CZidD+UPHwvRcyAdLzQNoTw2V0x7C7
         oLiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787126117; x=1787730917; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z0jE3gzT9/KW+Ch7bTrTGuJUus0VXch6kYVBXgjVeNE=;
        b=LkAyhNEFDKrWQRsLogQPE2UFobCJvKrUAx9AcIebN1M0XCYsvuYWiVe3rmGwbye1YM
         +8h08PAOcw6rYoGBPK2nrYYiEVDgnyNFGYDDljc1keql9sW5hdWuO2SC7siiqvx8dRd8
         cNtcgugkCN2gTuBHsqHJTlTPZdoQecPnP14oZpgz/8FLzWmFaUhxKbkE1Vp0CmGl0+9I
         ZC69uqPgvp7D5oDnf0WOQxmdgyK1DqRRr/rqh6uUxQDgnb8s3ojP20VeVW1yBZYRBcGI
         01q0naL37BxVmvaW6lerjPrQWhnjJbjcCs6xnLjOBCOeMz311mpbBV9O6MsrQignWGpL
         ouUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787126117; x=1787730917;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z0jE3gzT9/KW+Ch7bTrTGuJUus0VXch6kYVBXgjVeNE=;
        b=n7pLUTt2bRJi5ZXCmCe9Kpx+18dP+jffkSEQ8iL71hiHshrdTen9MFmyJyahmPeHG+
         jwmhSTaHcDaW9SrVLYhu+IU8G51Agy8P+F2L3poUBqM7qjzFmtCQjxKlEzi0Dz/+6eLu
         L3+qP1RvPIAu+Z36J727yjU3wEeCCCkOLhUbgJCiTXpwBf5erjYUMl7mYKB0HIwWwcaq
         HdIIhpAT1lowXJ+5Gq7g/1YeiawAYwdAdKMg+ct+yp7MRNkxwBO/bmaapa5UiFDf/U7+
         MR6uqSEdD4GPcQT9yqHLCAZ1vDDqmbnYtD75QlV80qg+hdgzzuTLMiZ7cEQ5LT49zZWp
         AUxw==
X-Forwarded-Encrypted: i=1; AHgh+RrQ4oyk8yHD0M1JSB98jA3GEMJXaTNElphcHdnT232FZ6Ipbv1qRfgVQsy+34HuwG9PitqOvu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws5tFu7EEV5EO7Tk1vDlTsI0y1P6xKC47gRDA1yUjnKHQoHJJ9
	7jeuDvLAXm+wP+aN1rVkeCAoNwcwr+uCTGoaMeux6r7lhOTAUZP+VMVcJdbc3GwmaiS2W8peGMa
	Qt89pvtIYwUvwgn6W6riH7Emd3EyhcXWiuES7DjG6
X-Gm-Gg: AR+sD12DPGtt3NxMsy1ACdf8M4/IKGQ2/lYIz2VWRgkMDjAJ3ol0GGx+01vglZSj3HB
	NJo8QwVFIDd3f0a9XdSMpceiV//L8JUsei7d7Z+xV1+x4WXHH8ViLMol+c3t/AYPcH3ouoWEwQ6
	lIAWBe65kkUsnUkxM7fv3svZwOAFjPLLKOQIqwaldKJFy1pk1Xia8BGMSSRPLaUUn9s3BzV3Kds
	89yQ/R9cbv8wZPShX/YCMWF3oumzglqspX7SIxbDE14u1LiFK4ErKbLu/ncFHpmdL/IXSXdmbUS
	mZD3/Z4cExoxDgCcABa0Bjl/5gz87MIVORTl+hr7bDxSxK+DNEKjKo0NTZOpfutzY8MM/3RD7W2
	5IHQuLLDQsLzITu39D7nfLLKXrjSz9oPomcXchKhStLIxo+oE0LvGz/66lpQUWMQJJLjMf0jIEB
	tr6tvSFHHPqidx0Zs=
X-Received: by 2002:ac8:5f87:0:b0:51a:bec0:1040 with SMTP id
 d75a77b69052e-52dd57d7a99mr21982071cf.12.1787126116158; Wed, 19 Aug 2026
 00:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819002050.3476701-1-shuangpeng.kernel@gmail.com>
In-Reply-To: <20260819002050.3476701-1-shuangpeng.kernel@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Aug 2026 09:55:01 +0200
X-Gm-Features: AcwNN1VsS45iVRLEmH9P5MrxlMzat4vRZ5QZUA9pnoNCEpr9m6epGfzcraRAdno
Message-ID: <CANn89iL2_QhxnZvng7LJ-Rx8KSX5pvymYf_mBgP8aFSeVkPY=g@mail.gmail.com>
Subject: Re: [BUG] nfc: KASAN: slab-use-after-free in nfc_llcp_rx_skb
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 2:21=E2=80=AFAM Shuangpeng Bai
<shuangpeng.kernel@gmail.com> wrote:
>
> Hi Kernel Maintainers,
>
> I hit the following report while testing current upstream kernel:
>
> KASAN: slab-use-after-free in nfc_llcp_rx_skb
>
> on commit: 3609fa95fb0f2c1b099e69e56634edb8fc03f87c (2026-01-04)

Are you sure this was not already fixed by 2b5dd4632966
("nfc: llcp: add missing return after LLCP_CLOSED checks") ?

>
> The reproducer and .config files are here.
> https://gist.github.com/shuangpengbai/70e3bdc241dbd675970fe89f30f0b84e
>
> I'm happy to test debug patches or provide additional information.
>
> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
>
> Decoded source path:
>
> use: net/nfc/llcp_core.c:1185 in nfc_llcp_recv_disc(), reading sk->sk_sta=
te
>      after nfc_llcp_sock_put() at line 1182; DISC dispatch is called from
>      net/nfc/llcp_core.c:1483 in nfc_llcp_rx_skb().
> free: concurrent socket release drops the final reference through
>       net/nfc/llcp_sock.c:646 sock_put(), then sk_free() releases the sam=
e
>       struct nfc_llcp_sock allocation.
>
> [   81.172360][  T830] BUG: KASAN: slab-use-after-free in nfc_llcp_rx_skb=
 (net/nfc/llcp_core.c:? net/nfc/llcp_core.c:1483)
> [   81.173044][  T830] Read of size 1 at addr ffff888119369812 by task kw=
orker/1:2/830
> [   81.173940][  T830] Tainted: [B]=3DBAD_PAGE, [W]=3DWARN
> [   81.173941][  T830] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + P=
IIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   81.173943][  T830] Workqueue: events nfc_llcp_rx_work
> [   81.173946][  T830] Call Trace:
> [   81.173947][  T830]  <TASK>
> [   81.173952][  T830]  print_report (mm/kasan/report.c:379 mm/kasan/repo=
rt.c:482)
> [   81.173959][  T830]  kasan_report (mm/kasan/report.c:597)
> [   81.173965][  T830]  nfc_llcp_rx_skb (net/nfc/llcp_core.c:? net/nfc/ll=
cp_core.c:1483)
> [   81.173973][  T830]  nfc_llcp_rx_work (net/nfc/llcp_core.c:1533)
> [   81.173976][  T830]  process_scheduled_works (kernel/workqueue.c:3262 =
kernel/workqueue.c:3340)
> [   81.173980][  T830]  worker_thread (./include/linux/list.h:381 kernel/=
workqueue.c:946 kernel/workqueue.c:3422)
> [   81.173984][  T830]  kthread (kernel/kthread.c:465)
> [   81.174000][  T830]  ret_from_fork (archkernel/process.c:164)
> [   81.174011][  T830]  ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> [   81.174014][  T830]  </TASK>
> [   81.187221][  T830] Allocated by task 4409 on cpu 1 at 75.384100s:
> [   81.188593][  T830]  __kmalloc_noprof (mm/slub.c:5658 mm/slub.c:5669)
> [   81.189018][  T830]  sk_prot_alloc (./include/linux/slab.h:961 net/cor=
e/sock.c:2245)
> [   81.189420][  T830]  sk_alloc (net/core/sock.c:2301)
> [   81.189779][  T830]  nfc_llcp_sock_alloc (net/nfc/llcp_sock.c:979)
> [   81.190222][  T830]  nfc_llcp_rx_skb (net/nfc/llcp_core.c:971 net/nfc/=
llcp_core.c:1478)
> [   81.190656][  T830]  nfc_llcp_rx_work (net/nfc/llcp_core.c:1533)
> [   81.193365][  T830] Freed by task 31 on cpu 196609 at 78.490492s:
> [   81.195183][  T830]  kfree (mm/slub.c:6670 mm/slub.c:6878)
> [   81.195531][  T830]  __sk_destruct (net/core/sock.c:2285 net/core/sock=
.c:2384)
> [   81.195937][  T830]  nfc_llcp_rx_skb (.net/sock.h:? net/nfc/llcp_core.=
c:233 net/nfc/llcp_core.c:1194 net/nfc/llcp_core.c:1483)
> [   81.196379][  T830]  nfc_llcp_rx_work (net/nfc/llcp_core.c:1533)
> [   81.199084][  T830] The buggy address belongs to the object at ffff888=
119369800
> [   81.199084][  T830]  which belongs to the cache kmalloc-1k of size 102=
4
> [   81.200297][  T830] The buggy address is located 18 bytes inside of
> [   81.200297][  T830]  freed 1024-byte region [ffff888119369800, ffff888=
119369c00)
>
>
> Best,
> Shuangpeng
