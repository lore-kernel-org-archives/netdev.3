Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400793E1D0D;
	Thu, 10 Sep 2026 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033333; cv=none; b=MHGZCQ9YhDgH8KnAhrnfWmHVUUxh5sQcFGKRVEaXiubnx23GtV8a0r+K06LZrIKp8cMBR7cx4s57geMOBQd3e3BhBM/6PZfSgeWkee+MdQFigW0BwoW0S2C4aIPQ0U9JOD2FYQCUEX5kf7NvshQiYgnAKwhGqbz/Gsqq6Gp8ZkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033333; c=relaxed/simple;
	bh=MmVsgNKKWN8IZ8Rp3Qyo39P5maWLE6qSTlV6nVRtucE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tmTgWckCILVNVldl6w6c5g/KEfP5P3NnBbLGh+gYdPcramvTrYn8wA1LoCzOGSyu8YfKiopLDgzDx77qkXJlf8ex4SHPOhOyrBFWbpbiixVVeiSl502CmL0o+NzSpUarqsUlCYWKYzA6azinJbFhiJTTaoV8BP/cRr4xIny6oAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVHyNU/p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVHyNU/p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8441F000FF;
	Thu, 10 Sep 2026 09:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789033331;
	bh=V0eWo8PDEQustwYntT2khGLj11eLgAJ4M/mNCEY7eis=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gVHyNU/pwFpC19gnb7ogTB5g6sJIBZcepfpGYy5fKZZ5fhQPkypZRbhStYQG6Lvk5
	 ngIv4mlcIUVauG/aDGlAgRkkcU31XN8sNdGfhADAlkXqGc82JgIZMM0rOFIPO2vW8f
	 3PZsgeBG8AxtEudwJ8UfanHBrYH464pBzb/2GcrrYipJdQ0lKMHWn1ehWmrUsPgTGx
	 nlwhuHGNQWETYYOtUVTl1JHJ/OGgUzpFuQAPAT3tlPOm/6VYYnuUdps3LHsNRpbhOT
	 gLvixtI0uI0IUIHh1H5El48T07GBDTijexyB6x0zCQMJSMUupAAFB6pLmQ33y3hfZM
	 7p3+YixCte3/w==
Subject:
 Re: [PATCH net-next] octeontx2-af: consolidate RVU AFVF device id definitions
From: netdev-bot+sashiko@kernel.org
To: yijiangshan@kylinos.cn
Cc: sgoutham@marvell.com, rkannoth@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 13667453960@163.com
Date: Thu, 10 Sep 2026 09:42:10 +0000
Message-ID: <178903333043.219967.16020637944756528838@kernel.org>
In-Reply-To: <20260908094051.666769-1-yijiangshan@kylinos.cn>
References: <20260908094051.666769-1-yijiangshan@kylinos.cn>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] Incomplete consolidation: the patch's stated goal
  ("octeontx2-af: consolidate RVU AFVF device id definitions") is only…

--

octeontx2-af: consolidate RVU AFVF device id definitions

This moves the local PCI_DEVID_OCTEONTX2_RVU_AFVF define from af/rvu.c into
the "PCI device IDs" block in af/rvu.h, and renames RVU_LBK_VF_DEVID to the
same name so both users share one definition.  The change is documented as
having no functional impact.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> index 9afb7ac8969b5..fb4870cd18e9e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> @@ -22,6 +22,7 @@
>  
>  /* PCI device IDs */
>  #define	PCI_DEVID_OCTEONTX2_RVU_AF		0xA065
> +#define	PCI_DEVID_OCTEONTX2_RVU_AFVF		0xA0F8
>  #define	PCI_DEVID_OCTEONTX2_LBK			0xA061

[Severity: Medium]
Is the consolidation complete here?  There is still a third definition of
the same macro in nic/otx2_common.h:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:
    #include <rvu.h>
    ...
    #define PCI_DEVID_OCTEONTX2_RVU_AFVF		0xA0F8

Since nic/Makefile adds:

    ccflags-y += -I$(srctree)/drivers/net/ethernet/marvell/octeontx2/af

the <rvu.h> included by nic/otx2_common.h is the header modified by this
patch, so after this change every object built from nic/ (otx2_pf.o,
otx2_common.o, otx2_vf.o, rep.o) sees PCI_DEVID_OCTEONTX2_RVU_AFVF defined
twice within one translation unit.

Both replacement lists are the identical token 0xA0F8, so this is a benign
redefinition and no warning or build failure results.  Would it make sense
to also drop the copy in nic/otx2_common.h, so that its users
(is_..._vf() in nic/otx2_common.h and the PCI id table in nic/otx2_vf.c)
pick up the definition through the included af/rvu.h?

As it stands, does the commit message claim more than the diff does when it
says the goal is to "consolidate RVU AFVF device id definitions" and
"drop the local define", given that two live definitions remain?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908094051.666769-1-yijiangshan%40kylinos.cn
