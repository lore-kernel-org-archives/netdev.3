Received: from mail-qv2-f7.google.com (mail-qv2-f7.google.com [74.125.230.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02C52D0C62
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 01:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789436975; cv=pass; b=d2YwN7+YhaiDea7om+TrkXxZkaWTrTQM7cnTqGpTU/bdVYn8p4X6Tw30mmdLUhynm0vahJ3PAcpHdxIci9dYMTnWkFU/1pXKuO21kZwITDFI9sHfPioLibL8wzVNT8xoVfmSaSXyzk++hh2IgVjHLv/xJ9QhDMVc+MCyl02f1qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789436975; c=relaxed/simple;
	bh=x+FU4SJGWsh1vn4yEtFsZ3aA/vqNWVzllOdxlwhOH+g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FE0cJVcyXJ0FlqX0Pv1P2RBq38C3JWM+MPt3puRfuNEIYhrfwL8kgf5Usl6QAQcvkRVS57YmI0FJOiOyoy+NSuP6pWE4YxtbmK0EhzxSRQSlqTX6T/AP87nx1Kr+PsR/jem0NRW5LuFHAOhRRU+k62Dmisfl1ILGPv+h2lqTx/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAg2TMW+; arc=pass smtp.client-ip=74.125.230.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAg2TMW+"
Received: by mail-qv2-f7.google.com with SMTP id 6a1803df08f44-90ccffc2654so27948026d6.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 18:49:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789436973; cv=none;
        d=google.com; s=arc-20260327;
        b=KYBFsB0rAEjrFLMUq+oer4E8xetfBgEEI3B2ImTpkN0fCaeoyjY5z14HJ0UEehgw0U
         U9889axeLof0Rv6J7bxByzXoUYix8tom63kd++U5zyqPcD3IsuDHUEWspSBrNMXeo90y
         /WW/QmidJQxF6Ow5Ylr1vjv9GwU46ElWL0+Juo2k4szPqMDWFy1QljrvR+0GJMmsGJeB
         GxVkMJyHrKBxvMyrN8MSgPTcxXr7aTy+m0rO/DN6Q6kwFEOlvKKIeqOPr+lnmGZVj+2b
         Jtz6PMJgFbM+tmqlbOuRdiCXwevSPJyZFxwMH/9z877CnGmAWQI4qZLTakUvgq692X/C
         Kbbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=9cCP8ATHiCM3DZdDsKWL2HHlyC1tigS+r4nKWX9jez8=;
        fh=ruc/gYqGRVOTFyakv8nB5ohQ1UEGSX6An0/U65KvIsQ=;
        b=EQMmIyhJJ6snhM2mgySA0AVcgmjc0ly26NvD+DnmZCXSbaCFTTvBIo4OgMPaHHXDtD
         uI9bCaU5103WlL9MNIXtyWo3dshw7J+387leLhesdVxX0xqARgteA8abVdIlBPc7RsMR
         kxK+l4y6dcPPdmLxoK2Zx0b/abh89BD9jRHW5V71ajkTAGp9vbs/7SJiuMryiX9O8zYn
         3DVwPFzL4HbsPv8u15T4rSmw9G0JJwnV2QK7Tv/HZQI10xUYyVzvboRdgPMNKyHmOHzx
         MNI5NdgJGI9Bn8OP3Z5WaOG72qL1KpEl+g+V5YqXrTi+/3TaXvnEk9XyEjt2tu4A9ewu
         71Lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789436973; x=1790041773; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9cCP8ATHiCM3DZdDsKWL2HHlyC1tigS+r4nKWX9jez8=;
        b=TAg2TMW+wbe2sTCMS3MFGzksHQzW3ImrCNe5rKLq3ZqgVW8MrK/p4Tqth9S/57HYlw
         fcOLlp8eP0lgfH7AhrE020R95TaQc4MxKU9GwhAsaSiP7eyKEioy8ZpfxFcgZSPwNMip
         0UsDw3Qkrl6xXBOu0l5RAOFf9wGHekCWbAQ6AMxP1oyTn+E4/xKF72LKPtMswNGVHvrl
         DALEE2iYK2c9ReJ0NvOYBwkkYrhO42JLlyAl4JMBuDmsrSBmggaS7vIUNKAfHHpf4+la
         AY/c4Lf+b7iSt+JjVDftCbxWuWW2MJ7g9xRenmUJBhjRkilK3NVNV4SxcZFULlnhyiHA
         WckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789436973; x=1790041773;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9cCP8ATHiCM3DZdDsKWL2HHlyC1tigS+r4nKWX9jez8=;
        b=StQr/ULylGF/OQuGR6SW2kV5F9lrYlvMuZnASTKjcntoAW8nfUh7vK4I3gDgjaupT7
         1SKzr/YlOizvBq45Fg/iXbR/dmSwDSg+rqu2FE/Bo4K3UJm45LZv7f4oaJ0NwDB3liCB
         aPUpgJb1eYLsTAmAISlIjbU/mK0AxAIqiI8QPxtivBcdTLjV/56ooYwfwwYD0gaZD0CE
         uaSBYXIReVIAj53470huM6XSYS2krGR8c5kg7MgG5WPXEBZ5qfCmKjnjNjDUaB7mprbi
         7pgLMTVSKzvE10IovW9BCJwmcOsGpc2StAfclcAZXYFHmx6FkBH6iXv8ghNvMT/0gvFa
         EEiQ==
X-Gm-Message-State: AFuF++lAAuYe2i9SXBsjZz07CHORbjea2CvN9h3P4c56a1gbIxHHzEkS
	peTmVcYbwUPZlijmi5ttReU/KtA0IktMKFhawPMvIGxfN2PqPiIZDIgWdU0OpoQeiGLhQqGH3Qe
	QT1PO716lMo2fm25ookha/I7fgLKVlnlkrBTVfdP1pbgLDrATQw==
X-Gm-Gg: AYBFou3rluaboC445FQFrjXgZ7orSGGVbt8BL/UdFNM9JonOPJeO/PBcT0epHBQdSrS
	LkWxaPbno0Zveyky+1gNO62zJw3kC56Y3iWGxZT31Gx7YbnTNTs5mMUqBhdtuloPsj8jHlnq1Wv
	9D3LRBw19hRR+RXdQGA0Gr9zrnk73y76XtGQ4n6rkQ7lvdveaY7gn1mT5VazGZi3FfZmqKTwyRm
	s7ELA4/cG09DKiaICMEbeWVPtCrBRgXTktVAkjwVOgqtKZQ9nTZjz0FiPZgBZaiWcTj0CXkbkjI
	eTsTZc5KM7CITVanBAsN9bNTbmT59st1rgw5tX1Q3Z8maqSXf8vHpWU=
X-Received: by 2002:a05:6214:2345:b0:910:3453:d4a7 with SMTP id
 6a1803df08f44-9122e65c134mr82476666d6.33.1789436972473; Mon, 14 Sep 2026
 18:49:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: jiabin deng <dengjiabin2023@gmail.com>
Date: Tue, 15 Sep 2026 09:49:19 +0800
X-Gm-Features: AcwNN1Wkb8iqVJYJHNixGe8po7o_nQWtmkOuwwuyqzt-GedXISps1PZMfaegazE
Message-ID: <CAFxp=AY2cVRQrZvB9WNnigbsobuw11NMG-cagHx0_V+ur2ToFw@mail.gmail.com>
Subject: mlx5e:zero-prefix corruption during TCP DMA-BUF RX - help requested
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello mlx5e and networking maintainers,

We are investigating reproducible data corruption: with SHAMPO enabled,
some TCP data is corrupted when received through mlx5e directly into
CUDA-exported GPU DMA-BUF memory.

The full expected number of bytes is received, but the prefixes of some
payloads become zero. The corrupted ranges end exactly at the next
64-byte boundary in GPU memory.

We have not determined whether this is a driver bug, a configuration
issue, or incorrect API usage in the reproducer. We would appreciate
your guidance in narrowing down the cause.

Receiver environment:

- OS: Ubuntu 26.04 LTS
- Kernel: 7.0.0-30-generic
- /proc/version_signature:
  Ubuntu 7.0.0-30.30-generic 7.0.12
- NIC: NVIDIA BlueField-3 B3210E E-Series DPU
- NIC driver: Ubuntu-packaged mlx5_core
- NIC firmware: 32.43.2400 (MT_0000001117)
- GPU: NVIDIA H20
- NVIDIA GPU driver: 595.71.05
- Receiver uses the CUDA Driver API, built with CUDA 12.4 headers
- Architecture: x86_64, 4 KiB base pages
- Link: 100 GbE, MTU 1500
- Receive configuration: tcp-data-split on, rx-gro-hw on

Tracing confirms that the receive path executes
mlx5e_handle_rx_cqe_mpwrq_shampo().

The sender is a standalone Python TCP program that sends reproducible
nonzero data from host memory. The receiver is a standalone C++ program
using Linux device-memory TCP interfaces and the CUDA Driver API.

Test procedure:

1. Allocate 4 GiB of GPU memory, export it as a DMA-BUF, and bind it
   to RX queues 8-15. Direct all test traffic to RX queue 8.

2. Before each iteration, fill the GPU memory with a nonzero value
   and call cuCtxSynchronize(). Then transmit the test data, in which
   every byte is in the range 1-255.

3. Receive the complete message using MSG_SOCK_DEVMEM and confirm EOF.
   Record the returned DMA-BUF offsets, lengths and tokens.

4. Keep all receive tokens outstanding. First read the data back with
   cuMemcpyDtoH(), then call cuFlushGPUDirectRDMAWrites() with
   CURRENT_CTX and TO_ALL_DEVICES, and read the data back again.
   These two reads produce the snapshots before and after the flush.

5. Compare the two snapshots with each other and the first snapshot
   against the expected data. Return the tokens through
   SO_DEVMEM_DONTNEED only after both snapshots have been saved and
   the comparisons have completed.

Each iteration uses a new TCP connection. Test connections do not run
concurrently.

Observed results:

We tested eight message sizes from 32 KiB to 4 MiB, with 50 iterations
per size:

- 400 iterations completed.
- 354 iterations contained at least one corrupted range.
- 20,707 corrupted ranges were recorded.
- All recorded corrupted ranges were zero-filled prefixes ending
  at the next 64-byte boundary in GPU memory.
- Corruption was present in both snapshots, before and after the
  explicit GPUDirect write flush.

A specific example:

- Packet payload length: 1448 bytes.
- Offset of the first payload byte from the start of the GPU buffer:
  2149169912 bytes.
- This byte offset modulo 64 bytes is 56 bytes.
- First 8 bytes: zero.
- Remaining 1440 bytes: correct.

Related source observations:

The receiver's drivers/net/ethernet/mellanox/mlx5/ directory and headers
under include/linux/mlx5/ are byte-for-byte identical to upstream
v7.0.12. The running kernel is an Ubuntu kernel; we have not yet run
this test on a current vanilla mainline kernel.

One possible lead is an interaction between SHAMPO end padding and
Relaxed Ordering writes. In this version, rq_end_pad_mode() disables
end padding only when LRO is enabled and write RO is supported.
SHAMPO therefore selects ALIGN; at the same time, write RO is enabled
on the payload MKey when the device advertises write RO support.

Commit e2351e517068 ("net/mlx5e: RX, Avoid possible data corruption
when relaxed ordering and LRO combined") describes a related issue
with consecutively placed LRO payloads. We would like to understand
whether SHAMPO might also need to account for a similar situation.
We do not yet have results from padding/RO diagnostic experiments.

Is our receive and synchronization sequence appropriate? Are there
known issues or fixes relevant to this configuration? Please also
advise which additional logs or targeted tests would be most useful
in identifying the cause.

Thank you for your time,
Jiabin Deng
