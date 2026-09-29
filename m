Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AB4544D64
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790704147; cv=pass; b=qYyS7YM4qBuBSnqcHA4YK/DKJrldB+c7QUrs8pkwMso8TG0mrT4p39tWdr3Xq0PtLZzWtAkpprV6xnCTkPn1bJZupVqxdbilSmGvHmF6iYewVeSZp5riTkmk/Rhe9B4JIlUw15HxIVRvxAOSoUS6XfZImKEAFNLrT7voyzriBvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790704147; c=relaxed/simple;
	bh=EgbFuS2Te6lm8qVRteJKBIzVGTmmynIix9CPN6Z3edM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGZbqRVXSed+8D4wecygee/CmXK4y+CjEczBRmjkM/gflVJ82IVIFBKxjSizTNe2CY3Nc9YaUiPDwMcLpA9AzchvMxLCV34886FErI1Xcq39HMqtrfJM4w9xAfvS52QwhJHTBMTYwrHVxL6W6TG0dqU5kuo/nuZ+Coi7/iqHqOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BjJk/HSI; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BjJk/HSI"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2af43c5b0cso587155566b.1
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 10:49:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790704144; cv=none;
        d=google.com; s=arc-20260327;
        b=lwxRCnLHqq4UEGAr+TELx3XARhdpg549hEtKLpq4E5VNN8RhVqr+B20Q06GeFcfeEA
         i0e6fRefWzaAWPexRAlG39Xy9yq6Dy4Cm7SE8av6YtI9JPq8D4zVYAvHkyWvkzsPgEDu
         4dDOmAdg9p3zsDjgoC4srFfUOCNctOmSHJTtu+ZvsoozkpRXJfwUSUxXUBNailCHLyD2
         s9r2lmHgLsjCSTbHITdmda+Zc6ut+NeLZCwMWdVpV8Py7drxPMnLBQKKd/m7dzYEXi+/
         CRxglyzoKW4+RPwFcgR8X/jJ1hmcVtliu5l0aOy85hPyeFa3+0lKv7/+9ubWQzj65jRF
         c57A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ThdPZzLhMx2EO2ovYKz1eeb+03YA/YkkzTBKjXEislI=;
        fh=NQoQ+BGStpXH7k7rq33CEdLVJRPdObqFqvXHmcDD5SE=;
        b=e+CYe2ied52dlPEPsqdeqHCZCa76bWYsbor2h5UiJdQdnssDHpAHGkkrv//CSe/NNb
         al2r9Yhl89OM1gXS/9svI0wFPS+MqzSpuc+6gBexwOCePRpjFP3f8rQBkdzLTqQeKbk+
         WGryWXv2vHkBI+IXmL0bkyA9oAQ6zaJrfWbtFENkkuWpI5IuoLqU/yUxqU1Df/363kn0
         844URexHZkCU5nGGJ79FZ9foth8cRX0jlxPOx37mpRihZGrx79Y5CpQR7jlpaONRzb65
         AKD9bGwTb01v+Brhp5YNg89KLY6E+1tX6DNHBeShudUqpzCUgzPdvgWyYIicHDrBHGch
         95oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790704144; x=1791308944; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ThdPZzLhMx2EO2ovYKz1eeb+03YA/YkkzTBKjXEislI=;
        b=BjJk/HSI+d90L8k+v3ogtsrpdBV9RBnS8n9GzfFAp2qbzia0SRN0MnUBBfbhTcD5bQ
         SKlFbDp1k3y4hc1U+ArLcT/CdMPQw9rDNtPllSD+amC96TQqeF36EtM+zHn16BWbFGQo
         v0YYl2anDZBgTxw2WKpOjBYmiZQkgZyjkQiW2hZC7677ZQaEhs1XMpoNUdlZ7pwRFczJ
         PtTN2FTUT+dqknbyhByvt9rPvNZF4KTFNegi8e3DNcGfF20nLlIS3EHgQvm9GDvyX7s3
         d7N+2F7wTDYiitczhVvx4FnL9GQe/QDPEqlpCEFIFWCOrSZlRyFZqvvnDXGwyei20/nw
         uC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790704144; x=1791308944;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ThdPZzLhMx2EO2ovYKz1eeb+03YA/YkkzTBKjXEislI=;
        b=GeEZCJvwsM7CO7hZLfuQ06IWlR2mf7/PqJuryMDSrdOIU0ca7SftKVUznoqFuKYvID
         5VG5pXyPyBuWXfxP1s2VrbhWtD6v9jLRbgEuYVzC+Kpnzmucz1z0fDlPQbRU2MRyWdDK
         TjFfHQIKh/7mFjX4751sRrOX0Mx1dKJpG9uWguFG2Z+3P/lqAxAxiEOIde88MmRbymhF
         LjipYCGe1KY/CBJWe28kjaKAsV5LHRUIgXfXeT+c/JawAKln7ar1zyxnSS/ecNTGipZ9
         cKJGNLHdcgWoPc04/ed0HEqPZV7mXLFK2XXoJuIKVTDxBUHT3z3i4oMJe4Hzwiy/08DU
         KOPg==
X-Gm-Message-State: AFuF++kUQNy6479ArjzrsY9lTGcjXr1vCT9uHfIbxV9kHTUHirqvB1q8
	yfZShAen2K0JbM+cdvCETNQbZdaG8Fi3W7TzOwlnsTgHykuVHg33hys9I8rC0fyBSq8VURSaJEl
	CpWCIggZSqYaj3IShcI1x/gMUBNpMuN+aryyaay2DEjAGOHj5iEIJGSWj
X-Gm-Gg: AYBFou0aTNs5x4kkw4da0STEhUOPC999ZOmky5+8hlWakjBQkCn471qMC8bf+TXjBij
	seH5b2PqzOsTwSbk2QP8wAieZV0ty+Bca/p4UiPxyIvDCB09bPUQbs7W0b9+m6yonv2e2iOH87a
	YHMKfHEXZ7lWRfI6dzHlBjVbW+b0FNjZ+X3ivdIVmu7J+4JBN1jahZIHeUFkZC/eOoFr3/8hrBJ
	T6WMOOWo/D69NEcHT633Wg+FoeZIan6/ashs8hFLwhonURnSfyiEbiCXQ3ABZfnB23MabjZ2SwV
	8qPHSwRDLYiPmY0nOnEozJl+x9+hbRbvWMXa2f/KdpivImKdsQZhYk01
X-Received: by 2002:a17:907:7289:b0:c2d:e067:275d with SMTP id
 a640c23a62f3a-c2e15c0da9amr18432266b.2.1790704143373; Tue, 29 Sep 2026
 10:49:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922194533.631387-1-joshwash@google.com>
In-Reply-To: <20260922194533.631387-1-joshwash@google.com>
From: Joshua Washington <joshwash@google.com>
Date: Tue, 29 Sep 2026 10:48:51 -0700
X-Gm-Features: AclHuK-4Jen_xaBqivrTS2m8jiJGtwTSvDPOut6gW97lQXY41zUzIIPLnIv2r1s
Message-ID: <CALuQH+VWjT2VZTOUjseLfcON4=Me6v99KyW=k=Uh2Y1dvpNkcw@mail.gmail.com>
Subject: Re: [PATCH net v2 0/9] gve: various XDP fixes
To: netdev@vger.kernel.org
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jordan Rhee <jordanrhee@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tim Hostetler <thostet@google.com>, Ankit Garg <nktgrg@google.com>, 
	Eddie Phillips <eddiephillips@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 12:45=E2=80=AFPM Joshua Washington <joshwash@google=
.com> wrote:
>
> This patch series includes a number of XDP-related fixes, both in the
> control plane and the dataplane.
>
> A summary of the changes:
> 1) fix an issue where XDP packets weren't being counted against NAPI
>    budget
> 2) fix an issue where XSK buffers that have not been processed are
>    leaked when disabling XSK pools
> 3) fix an XSK buffer leak when an RX error descriptor comes back from
>    the hardware
> 4) fix a NULL dereference due to incorrect registration of XSK pools on
>    queues not set up in XSK zero copy mode
> 5) fix a deadlock introduced by attempting to acquire the netdev lock
>    after it has already been acquired
> 6) fix a racy NULL dereference due to DMA umapping the XSK pool before
>    queues are fully stopped
> 7) fix potential data race on priv->xsk_pool when the field is set while
>    NAPIs are enabled
> 8) attempt to register memory model in all cases when disabling XSK
>    pools
> 9) clean xdp frames when tearing down DQO queues
>
> ---
> v2:
> - introduce 3 new patches (7, 8, 9) based on Sashiko feedback
> - corrected stat counting for packets according work_done behavioral
>   change (patch 1)
>
> Eddie Phillips (1):
>   gve: prevent XDP frame leak and corruption during DQO TX cleanup
>
> Joshua Washington (8):
>   gve: increment work_done for XDP and error packets
>   gve: fix XSK buffer leak when rings are stopped
>   gve: fix XSK buffer leak on error descriptor
>   gve: don't register xsk pool on pre-existing queues in RDA mode
>   gve: fix napi_disable deadlock when attempting to disable XSK pools
>   gve: fix NULL dereference from premature XSK pool DMA unmap
>   gve: disable NAPI when registering XSK pools in QPL mode
>   gve: ensure XDP mem model is registered when disabling XSK pools
>
>  drivers/net/ethernet/google/gve/gve_main.c   | 153 +++++++----
>  drivers/net/ethernet/google/gve/gve_rx_dqo.c |  31 ++-
>  drivers/net/ethernet/google/gve/gve_tx_dqo.c | 256 +++++++++++++------
>  3 files changed, 314 insertions(+), 126 deletions(-)
>
> --
> 2.55.0.1082.g2b9226bbc0-goog
>

In the interest of getting some of the more trivial fixes merged, I
will send out a v3 with only the very simple fixes, and continue
working on the more problematic/invasive changes in the background.
This will include patches 2, 3, and 5.

-- Josh
