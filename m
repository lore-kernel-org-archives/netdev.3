Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53692F1FE4
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 02:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790563638; cv=pass; b=po5gcC4jjp7tzYGaXSUlJgBC/tG//oOojQcGIpgyFKc9sTNwxW6MyQiW/6T+Z1N54gf4cNWECOSDgQZ+DW6VQ47smStfUYANIBSrZPkACcSboQkMMW9taCJldsL7GJ8gg0T6L7E0trgKlChpnnd2sda30t009KxCqK27NzrBQ+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790563638; c=relaxed/simple;
	bh=kfLoILawQtt3GmHszvYMld0py7d1Fw/qISyON4KY3vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8YBjWQltzGKhlEWX8lbnn99XO8Oa1MGfHdyvoiamSsNihiELxJenb1b87dtRxxNr0zyGUUWXX2lyqj1jruvtxiribHfnbQafknmCEywH4Z6Ttub4xdiZWNluTvOtol6LwGUXzz91yl4c2TiQ6dycqDp4CHz5M0kNfmZ58p2VZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sl9KQhN+; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sl9KQhN+"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d8facae850so59225ad.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 19:47:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790563635; cv=none;
        d=google.com; s=arc-20260327;
        b=dmDyvHFOK72nfCJ91MjC7FapgvvRQrmuOFwfPy8VoZpRdsrEvCFB02wk/C3cUnRiTJ
         76aoskThoJybhDEDyHdPazoxI1CxwIWThEBrOh4uletMOc2rLHcjGwnpilUer4TqXZtV
         3Dsg9po/lyix8ACVrZWHGIJ+vAfCTlqkpy0pjZGSTwo1VMlOfzcimsfsHR0FXuiDMza8
         Fz1wCUkk6bCNs74apQN5eBEWINptJva1F3pueJ/dIZJxcKE3zgyrkWj6WNWzQvx8sDC5
         upFPg5ZuEUYUN2RMXk9z6b3G6i6hdhbRAX03z1xhvCj+YhzsDAAJfTh6MbjnlOymYNwS
         Q35g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=augEudhXCRPhiwglRSNBL2Iu+v3w4mRzMH115XwWtzU=;
        fh=WVGu8qasLbReNH5Z0xeeHlhMgVnzRxXG1LS2e8RBMDA=;
        b=btO/dPEbddVAXCPb8SQEv6MzF5xCoBTojs+Rf+W5yunsigVj2MT8DtpD1nlpKilVnY
         le+U56DEJi12ETedSjZIEPZunma9PHeSwx4QJE13u2doSX3wuAEVKHz0br7d/NMpbBmE
         ZlcmFaKiRnYVmQMem39Bl4KL4CZt5KooP4UoOIaGCffJFODtyYpYtwVUtmja6gtJhzS4
         eNQrD0qwQxRiezomGglq7Nn4cylRfqDRAGSlHP7Rz+h70RVteos5oCbkIBDaqN4elrNP
         YEqnMmPufasDelbo8U4cVaW937PTpj9aqpduzMB2Gdh7tNCfQviQnbzQlg4Ygz5HP/W0
         fFlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790563635; x=1791168435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=augEudhXCRPhiwglRSNBL2Iu+v3w4mRzMH115XwWtzU=;
        b=sl9KQhN+QEgFViLK1ZumHInb9dLoKmqlMLEtfjnC5c/NImBRV2X84xcLiDOgtWvEoX
         rXDWHJFPddtrenuz+7cGSDkEGpZ1PXkEEcPgXvj9KkXj/gObToD7Sh2soBldwb1PNna9
         pP9/pdFvSfoWYuXWyDxKwEHnqZ7LV7Km5XYapKC+0AveZaCz9Tw7pBjcfRQ7NgdFTOBG
         66ZkjiwkIybx+E5nLzNMQtdv3LWM1iyelLpQZ2Y4yXCY8ynISkvDR2Wa3sUd+hjPaSB9
         Ry+uMw9/+wuf6WIfJMyy1rV6A+CCS3QyxgqWSSuvJXOsTEp46pGK2qnLp9CH0i3QNk2V
         maGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790563635; x=1791168435;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=augEudhXCRPhiwglRSNBL2Iu+v3w4mRzMH115XwWtzU=;
        b=eJV2txVHk+oWV/mHUiem0GGACIcSUoLZMNE5+4b2NaymlTxsRj/7CSGWpYyQyohYle
         H7urkQJcEAHfSCauSeeJnUM3M8TASwsNtLNV+S9t6FZWff6hol7Y1VpOlFFJHAtxv9p9
         IBJXnMlPBLMU9wJ30vCBSYovONNYgbfzRFYF5JhI05FQ1SWUJ3inb9ZvGE5NqLDUtG5D
         GokH2N3xEXfQnWJKgH3Fc/WbDpX5vgonUbPyBHx0lRRhOSF5c46kP25l/vAneTgEqaK7
         aBQ38EMqwOovPVWnJygtdqYKh60mpyF8aBy5XTr6yLAu3+YRdvE1kruJ5L0C24L4nKzR
         nWog==
X-Gm-Message-State: AFq9FYKq+4mKGGl+usR2LWhHL3v4J2fF2vNg4V9U9v1n48qpC2apmyHO
	IRBI6439tzNPQPRkH2OhIUZ/l8yB8shC/TM1DsBoiJwGrO+SAcK6VhQ6bbUpDQ78Pb+KGBQAcdm
	b4n857osRaPNKhXVFmKkzFpl6HCbv2/HOUKCr5OLc5s5wLh9tCYTf71lu8TU=
X-Gm-Gg: AYBFou24knDkIHaVVgH3Kt26ciPpcY0UVFDliqdH+8tCeS6NU3BLjd80SLSahD9hUWJ
	oSQ2aGqfBV4M4PlCCOoDFOd9AErDeixUf+wvDaTpsCADvznH2pb8RzF6wMjMVPfNnRNln43aPaP
	QUsR365Q74TTGJAtF4AZ0dxX3edqS1dFcSU19TvLmXH8PkhmKEFGNm3N2l9TndAL9dTQAndUdQy
	SXRvrP+VM6LBPeo2jWwU+9EkpLlslD9jO3N0yJoAjQMdnjavQy+u0LudDlVoSD12IqruQf3d88O
	eZzONbyHp1SFrT4HiBgGoXDIAtIuoWhQNEDf0l8aaIgo+075xM4v/q0ACzADst+wfg07MyZBqQC
	JKmSIQrtBo6lAfpzWOl8HzS4k7UH1ZhmEumDKDQGcEW8nmWNrlgmWiOE=
X-Received: by 2002:a17:902:d54f:b0:2d5:c090:3810 with SMTP id
 d9443c01a7336-2dfa615a5b9mr3166565ad.2.1790563634286; Sun, 27 Sep 2026
 19:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924185316.2831077-1-hramamurthy@google.com>
In-Reply-To: <20260924185316.2831077-1-hramamurthy@google.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Sun, 27 Sep 2026 19:47:01 -0700
X-Gm-Features: AclHuK-e80j_tEsr2eWKoIEd6Nv5MH1_swonyIC0fjDKChHLUEFmd8yxlyMBtRM
Message-ID: <CAEAWyHfHGhExuWf77nG7W=Bh0crzdb-LQvR0wsc7dRrtjs9yBw@mail.gmail.com>
Subject: Re: [PATCH net-next v8 00/12] gve: AdminQ mode related refactors
To: netdev@vger.kernel.org
Cc: joshwash@google.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, jordanrhee@google.com, willemb@google.com, nktgrg@google.com, 
	maolson@google.com, thostet@google.com, jacob.e.keller@intel.com, 
	debarghyak@google.com, kees@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 11:53=E2=80=AFAM Harshitha Ramamurthy
<hramamurthy@google.com> wrote:
>
> This series is preparing the driver for the addition of a new control
> plane mode(MailboxQ) by commonizing and reusing as much code as possible.
> MailboxQ is a new control plane infrastructure which uses mailbox queues.
> This is a new control plane to communicate with the device when the drive=
r
> is running on bare-metal instances as well as newer versions of the devic=
e.
>
> This series contains 2 main changes to the gve driver's existing control
> plane(AdminQ):
> 1) refactor some initialization/teardown path methods to make it work for
>    both control planes.
> 2) add gve_ctrl_ops structure to the driver for various control plane
>    operations
>
> The refactors are mainly around the init, reset and recover paths so that
> functionalities could be moved into the control ops like 'set_num_queues'=
,
> 'set_num_ntfy_blks' etc.
>
> This patch series only sets the control ops for AdminQ mode. This is
> intended as a preparation for adding MailboxQ mode in upcoming series
> which will add the new control plane infrastructure and then introduce
> the corresponding control ops for MailboxQ mode.
>
> The entire list of future patches can be found here for reference:
> https://github.com/hramamurthy12/linux/commits/gve-mailbox-queues/
>
> Changes in v8:
> - Patch 6(Sashiko):
>     - call gve_queues_stop() directly in gve_queues_start() to handle XDP
>       info unregistration
>     - drop gve_queues_mem_remove() from gve_queues_start() and leave it t=
o
>       the caller; this moves a few function definitions around to avoid
>       forward declarations
>     - revert the gve_mgmnt_intr() behavior change from v7
>     - handle the TOCTOU when checking for a pending reset
>     - record all configurations in priv before sending an AQ command that
>       can result in a reset
>     - update the commit description regarding teardown-related resets
> - Patch 8(Sashiko):
>     - gate mgmt IRQ and notify block teardown on different conditions
>     - move gve_teardown_notify_blocks() from gve_reset_device() to
>       gve_teardown_device(), and tear down notify blocks as part of the
>       device reset
>     - don't set block->irq when tearing down notify blocks; instead guard
>       the disable_irq() call in gve_remove_napi() on whether the IRQ was
>       requested
> - v7: https://lore.kernel.org/netdev/20260916165533.2187434-1-hramamurthy=
@google.com/
>
> Changes in v7:
> - All changes are in patch 6(Sashiko):
>     - Return IRQ_HANDLED instead of IRQ_NONE in gve_mgmnt_intr()
>     - disable service task instead of stats report task for gve_probe() e=
rror
>     - cancel stats report in gve_free_stats_report()
>     - extract gve_teardown_control_plane_resouces() and gve_adminq_free()=
 into
>       new gve_reset_device() to ensure the device reset is triggered befo=
re
>       stopping queues
>     - don't call gve_queues_stop() in the gve_close() error path since th=
e
>       gve_reset() takes care of that.
> - v6: https://lore.kernel.org/netdev/20260909191136.3811892-1-hramamurthy=
@google.com/
>
> Changes in v6:
> - update commit message to be more consistent with code (patch 1,9 Sashik=
o)
> - call out MTU validation change (patch 1, Sashiko)
> - A few other Sashiko related fixes (error propagation in patch 2, drop d=
ouble
>   logging in patch 5, drop unintentional type conversion in patch 11)
> - v5: https://lore.kernel.org/netdev/20260903215606.31633-1-hramamurthy@g=
oogle.com/
>
> Changes in v5:
> - This series contains 12 patches since 3 patches from v4 were applied
> - Picked up Przemek Kitszel's Reviewed-by tag
> - Honor device provided default no. of Qs and max rx buffer size correctl=
y (patch 1, Sashiko)
> - drop unnecessary header files and __maybe_unused tag (patch 4, Sashiko)
> - fix workqueue disable count, destroy rings before stopping Qs, stop que=
ues in error path
>   in gve_close, preserve ordering of gve_turndown->gve_destroy_rings->gve=
_queues_stop
>   during close and reset (patch 6, Sashiko)
> - drop double logging in all paths for queue creation/destruction (patch =
11, Sashiko)
> - v4: https://lore.kernel.org/netdev/20260814021406.3044324-1-hramamurthy=
@google.com/
>
> Changes in v4:
> - Reduce code churn by placing new functions directly in gve_adminq.c, in=
troducing final tab spacing
>   and using local variable (Przemek Kitszel)
> - Fix kdoc formatting and drop spurious management interrupt(patch 9)
> - Propagate release_db_resources naming change (patch 12)
> - Remove double logging in destroy queues path (patch 14)
> - v3: https://lore.kernel.org/netdev/20260803184630.3813311-1-hramamurthy=
@google.com/
>
> Changes in v3:
> - Fix driver compatibility verification in the reset and recovery paths (=
patches 2, 8).
> - Mark gve_adminq_get_device_properties() with __maybe_unused ahead of it=
s usage (patch 7).
> - Refine error handling and resource cleanup in reset, probe, and queue c=
reation paths (patches 8, 9, 11, 14).
> - Keep IRQ doorbell allocation/release in control plane resource helpers =
(patch 12).
> - Minor fixes: fix TOCTOU issue for link speed, correct kdoc comments, an=
d remove redundant teardown calls (patches 4, 11, 15).
> - v2: https://lore.kernel.org/netdev/20260602235900.3050782-1-hramamurthy=
@google.com/
>
> Changes in v2:
> - Rebased against latest net-next to resolve apply failure for patch 5
> - Fixed a few typos in commit messages of patch 9 and 14
> - Fixed a kdoc warning in patch 9
> - v1: https://lore.kernel.org/netdev/20260601175437.3767283-1-hramamurthy=
@google.com/
>
> Harshitha Ramamurthy (6):
>   gve: add struct gve_device_info to hold device properties
>   gve: introduce control plane operations structure
>   gve: introduce ctrl ops to set vectors and Qs
>   gve: introduce gve_adminq_get_device_properties()
>   gve: refactor gve_init_priv for reset path
>   gve: add ctrl ops for queue operations
>
> Joshua Washington (6):
>   gve: simplify reset logic
>   gve: add gve_ctrl_ops for gve initialization/teardown sequences
>   gve: split up notify block allocation and setup paths
>   gve: introduce new methods to handle IRQ doorbells
>   gve: setup and teardown management interrupts
>   gve: add link status/speed ctrl ops

There are a few high/medium issues that Sashiko has spotted for patch
6. Will fix in v9.

>
>  drivers/net/ethernet/google/gve/gve.h           |   87 +-
>  drivers/net/ethernet/google/gve/gve_adminq.c    |  376 ++++++--
>  drivers/net/ethernet/google/gve/gve_adminq.h    |   30 +-
>  drivers/net/ethernet/google/gve/gve_ethtool.c   |    5 +-
>  drivers/net/ethernet/google/gve/gve_flow_rule.c |   15 +-
>  drivers/net/ethernet/google/gve/gve_main.c      | 1067 ++++++++++++-----=
------
>  drivers/net/ethernet/google/gve/gve_utils.c     |    4 +-
>  7 files changed, 972 insertions(+), 612 deletions(-)
>
> --
> 2.56.0.rc1.310.g51773c2048-goog
>
