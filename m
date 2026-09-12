Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3A7416870
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 09:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789205773; cv=none; b=MxbbSkXKoZXFAeSDxc83CuVTQnJZRg4eAmM1FkUwJtI/60W7y/wDzjOM0y3kj+rvxlRRjuwp/ojUP37Hmmzrq03Wg1kP+51VtW3PsmBLXb2LVE6VxB1BxSzwDurgPDx6IZeyjxUIR4O72UomDYIHd5iPbx8ah0XdBeHyobLBRiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789205773; c=relaxed/simple;
	bh=5PP8v4e2du4jh4kzrNUVVWrWELbxgQwsg4sJKZimPh4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=etID5ikkBNOvMSBIEvp4Xl7MdPPxruG22z91Kbu2hxiqTQ7JbZUMJO5ZVIaoQh7I14SKlh4BbZBVM0v56JKG8Mxerd7cWnLzXTp2CjNxQ2P8VO6kdECFIvIrLWXcJbfmprYJDXpGp/j5c37J1REo7TZS+nCAGJL+wfAfXHGnU+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRM605ro; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRM605ro"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169D61F000FF;
	Sat, 12 Sep 2026 09:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789205767;
	bh=K4VBslU50Db8yLz4VgYqKBKLwKUHuhdN+m9L2JFZUT4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lRM605rooaXUHtr/Z4ppO3h+ebI51gvG0eDQ2GXmaT0uCZ5ZUQ+wRkS/idCfPy6j0
	 vb3N6WDk6LEQAJy5yDjDyDjcRgv2Q0bcFBD6vEH+7IeSCQnIed4XPctxjcgfxf+D/i
	 Ijj8FDkpkPUEeB2Ebfm6r6qamckXfJl+u2sfOuJSxI7EVpQCtAm/EckONanFtoc0uR
	 ZywuSSyKXYlJ6fJqNJWXVWoK6fhIs8LsMgKEPdhyOqhIuKL+iReppnsiUQm2lxHKfc
	 jeg0jhMiDfwc1bKtTDpPn8B+VmvHYMUJ37lEwkBBN/6xAuaVuKc+LzA2tm13mcHGkR
	 KujB91SKrsroA==
Subject: Re: [PATCH net 2/5] idpf: disable PTM on probe failure and on remove
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 ae878000@gmail.com, mhun512@gmail.com, joshua.a.hay@intel.com,
 sridhar.samudrala@intel.com, milena.olech@intel.com,
 vadim.fedorenko@linux.dev, willemb@google.com, jacob.e.keller@intel.com,
 przemyslaw.kitszel@intel.com, jbrandeb@kernel.org, alexander.nowlin@intel.com
Date: Sat, 12 Sep 2026 09:36:05 +0000
Message-ID: <178920576561.219967.8682374011760278855@kernel.org>
In-Reply-To: <20260908214502.528440-3-anthony.l.nguyen@intel.com>
References: <20260908214502.528440-3-anthony.l.nguyen@intel.com>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

- [Medium] Incomplete unwind: the new `pcie_ptm_enabled(pdev)` guard in
  `idpf_decfg_device()`…

Pre-existing issues:
- [Medium] Unserialized read-modify-write on shared upstream PTM state:
  `idpf_decfg_device()` (idpf_main.c:111-112) now calls…

--

idpf: disable PTM on probe failure and on remove

idpf_probe() enables PCIe PTM but never disables it, so the PTM enable
counts of the device and of its upstream path stay elevated after probe
failure or removal.  This adds a pci_disable_ptm() call to
idpf_decfg_device(), guarded by pcie_ptm_enabled() so that a failed
pci_enable_ptm() does not drive the count negative.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
> index 9840580fbe51..129bccaa6baa 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> @@ -106,6 +106,11 @@ static int idpf_dev_init(struct idpf_adapter *adapter,
>   */
>  static void idpf_decfg_device(struct idpf_adapter *adapter)
>  {
> +	struct pci_dev *pdev = adapter->pdev;
> +
> +	if (pcie_ptm_enabled(pdev))
> +		pci_disable_ptm(pdev);
> +

[Severity: Medium]
Does the pcie_ptm_enabled() guard skip the disable in exactly the case
the commit message describes as broken?

pcie_ptm_enabled() only looks at this device's own count:

    static inline bool pcie_ptm_enabled(struct pci_dev *dev)
    {
        return dev && atomic_read(&dev->ptm_enable_cnt) > 0;
    }

But pci_enable_ptm() in drivers/pci/pcie/ptm.c enables the upstream path
first, and only then tries the local device:

    parent = pci_upstream_ptm(dev);
    if (!parent)
            return -EINVAL;
    /* Enable PTM for the parent */
    rc = pci_enable_ptm(parent);
    if (rc)
            return rc;
    ...
    if (atomic_inc_return(&dev->ptm_enable_cnt) > 1)
            return 0;

    rc = __pci_enable_ptm(dev);
    if (rc) {
            atomic_dec(&dev->ptm_enable_cnt);
            return rc;
    }

So when __pci_enable_ptm(dev) fails, the local count returns to zero but
the parents that were just enabled and refcounted are never unwound.
__pci_enable_ptm() fails locally for a device with no PTM capability, and
for an endpoint that is not a PTM requester:

    if (!ptm)
            return -EINVAL;
    ...
    case PCI_EXP_TYPE_ENDPOINT:
    case PCI_EXP_TYPE_LEG_END:
            if (!dev->ptm_requester)
                    return -EINVAL;

idpf_cfg_device() discards that error and continues probing:

    err = pci_enable_ptm(pdev);
    if (err)
            pci_dbg(pdev, "PCIe PTM is not supported by PCIe bus/controller\n");

In that state pdev->ptm_enable_cnt is 0 while each upstream PTM device
sits at +1, pcie_ptm_enabled(pdev) is false, and idpf_decfg_device() does
nothing on probe failure or on remove.

Doesn't that leave the upstream enable counts and PTM Control bits
elevated with no bound driver, which is what the changelog says this fixes
("the PTM enable counts of this device and of its upstream path stay
elevated with no bound driver")?  Every bind/unbind cycle of such a
function, for example an idpf VF under a PTM-capable upstream port, would
add another leaked upstream reference, and a sibling endpoint's later
pci_disable_ptm() can then never bring the shared parent back to zero.

Calling pci_disable_ptm() unconditionally is not the answer either, for
the reason given in the changelog.  Would it make sense to record whether
pci_enable_ptm() succeeded in idpf_cfg_device() and key the unwind off
that instead, or to have the PCI core unwind the parent enables on local
failure?

[Severity: Medium]
This is a pre-existing issue in the PCI core and was not introduced by
this patch, but this is the first place idpf reaches it, so noting it
here.

pci_disable_ptm() recurses over bridges shared with sibling endpoints,
and the counter transition and the config-space write are separate steps
with no common lock:

    if (atomic_dec_and_test(&dev->ptm_enable_cnt))
            __pci_disable_ptm(dev);

    parent = pci_upstream_ptm(dev);
    if (parent)
            pci_disable_ptm(parent);

pci_enable_ptm() is symmetric:

    if (atomic_inc_return(&dev->ptm_enable_cnt) > 1)
            return 0;

    rc = __pci_enable_ptm(dev);

Can a remove running idpf_decfg_device() (shared parent 1 -> 0, then the
disable write) interleave with an asynchronous probe of a sibling under
the same upstream port (0 -> 1, then the enable write)?  If the sibling's
enable write lands before the remover's disable write, the shared parent
ends up PTM-disabled in hardware while ptm_enable_cnt is 1, and the
sibling would then gate on pcie_ptm_enabled() in idpf_ptp and offer
getcrosststamp over a PTM path that is off.

The window is narrow and confined to driver bind/unbind, and every
pci_disable_ptm() caller in the tree has the same exposure, so this looks
like something for the PCI core rather than this patch.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908214502.528440-1-anthony.l.nguyen%40intel.com
