Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8464B1275;
	Sat,  5 Sep 2026 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788622183; cv=none; b=X5En3OW0tUtLutLRQfBtr+fTVp0TBX5oUtKUZ3nsrQJh4e8sI2k5Wi1XY60W1NOKYm+qv52gtv9U2EblBmafjDozx2ypFd000GwosxGQ5vEuyzu8pdFL1GvIFlOQFQlsv42yazK9J9FJLwPsSWbr/JgxGcnb/TQERx80wJ8cx7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788622183; c=relaxed/simple;
	bh=cMHEzdsWrpE8tM9NyJ61S0/m37Il6Q2RWiRUrjmMrBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5EFEHQ1ZO1fjK5QXAXKtK8uCojBCSm9Gf8TYM+fK+PJKastrrGR7NCmB0lTgXsgDQAnovk7RA7iWcnD91G9PR8yuzYzLpDvP5pYS4ga5rYp0KG7Mt9naucTVkoeJ9bgZPvZc5+N0n36tCH8D/zX15ITID0KqXA0kpj8IERHCo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWwUkG76; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWwUkG76"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A5B1F00A3E;
	Sat,  5 Sep 2026 15:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788622182;
	bh=TQHMp2DzrglIa9hhIQ1pITZR1pPZpkYnUwpYP4H54jM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OWwUkG76Srw4NBaRKFJhv81DlCLDpLxxnMMLk+i8wTRup6ngnw8qYH7f06zbMIEJn
	 0if+R4gns6pofNXS9qhhsBnojs6kt6aNyc+stwNhXh8LN3r/JWoGVfhBvf+ogGpdTc
	 62ya4t41uHNUjEXKhG+BIf5uHgYp/qdbPPe84062uf2+KSngjSJQs7qh7GCaWO+0SP
	 VLy+HXGiLxEoGyVNeDoHnSX51dIRkLzHoQsmnrB8VWOx8FXhgr/VOhnq0oVqyy+ycd
	 Omm0EEAzw+3EPwKg552+mgjOYPhsG/djqtvHMv0D6kN1FzCUbDX2EiWkURQx+7T59R
	 +X1FAbqOkBgvQ==
From: Simon Horman <horms@kernel.org>
To: weir@nebusec.ai
Cc: Simon Horman <horms@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	error27@gmail.com,
	kees@kernel.org,
	pengpeng@iscas.ac.cn,
	raoxu@uniontech.com,
	rosenp@gmail.com,
	dddddd@hust.edu.cn,
	joe@dama.to,
	ian.ray@gehealthcare.com,
	kuniyu@google.com,
	linma@zju.edu.cn,
	vega@nebusec.ai,
	rakukuip@gmail.com
Subject: Re: [PATCH net v2 1/1] net: nfc: fix use-after-free in nfc_get_local_general_bytes
Date: Sat,  5 Sep 2026 16:29:10 +0100
Message-ID: <20260905152910.94019-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <7023ed1e8d7522917d699222d9d5db7135184abb.1788157546.git.rakukuip@gmail.com>
References: <7023ed1e8d7522917d699222d9d5db7135184abb.1788157546.git.rakukuip@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/7023ed1e8d7522917d699222d9d5db7135184abb.1788157546.git.rakukuip@gmail.com?part=1
---
net: nfc: fix use-after-free in nfc_get_local_general_bytes

This commit refactors nfc_get_local_general_bytes to accept a caller-provided
output buffer instead of returning a pointer to local->gb. All callers are
updated to provide their own destination buffers to prevent use-after-free
issues when the local reference count drops to zero.

[ ... ]

> diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> --- a/net/nfc/nci/core.c
> +++ b/net/nfc/nci/core.c
> @@ -780,26 +780,24 @@ static int nci_set_local_general_bytes(struct nfc_dev *nfc_dev)
>  {
>  	struct nci_dev *ndev = nfc_get_drvdata(nfc_dev);
>  	struct nci_set_config_param param;
> +	u8 gb[NFC_MAX_GT_LEN];
>  	int rc;
>  
> -	param.val = nfc_get_local_general_bytes(nfc_dev, &param.len);
> -	if ((param.val == NULL) || (param.len == 0))
> +	nfc_get_local_general_bytes(nfc_dev, gb, sizeof(gb),
> +				    &param.len);
> +	if (param.len == 0)
>  		return 0;
>  
> -	if (param.len > NFC_MAX_GT_LEN)
> -		return -EINVAL;
> -
> +	param.val = gb;
>  	param.id = NCI_PN_ATR_REQ_GEN_BYTES;
>  
> -	rc = nci_request(ndev, nci_set_config_req, &param,
> -			 msecs_to_jiffies(NCI_SET_CONFIG_TIMEOUT));
> +	rc = nci_set_config(ndev, param.id, param.len, param.val);

[Severity: High]
Does replacing nci_request with nci_set_config introduce a locking regression
here?

The original code used nci_request, which acquires ndev->req_lock before
proceeding. The new helper nci_set_config directly calls the unlocked
__nci_request:

net/nfc/nci/core.c:nci_set_config() {
    ...
    return __nci_request(ndev, nci_set_config_req, &param,
                         msecs_to_jiffies(NCI_SET_CONFIG_TIMEOUT));
}

Because __nci_request modifies ndev->req_status and reinitializes
ndev->req_completion, calling it without synchronization can corrupt the
wait queue if another thread is concurrently executing a locked nci_request.

This polling path can be triggered by unprivileged user space via the netlink
NFC_CMD_START_POLL command. Is there a way to restore the req_lock
synchronization for these configuration updates?

>  	if (rc)
>  		return rc;
>  
>  	param.id = NCI_LN_ATR_RES_GEN_BYTES;
>  
> -	return nci_request(ndev, nci_set_config_req, &param,
> -			   msecs_to_jiffies(NCI_SET_CONFIG_TIMEOUT));
> +	return nci_set_config(ndev, param.id, param.len, param.val);
>  }
