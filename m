Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF874A4983
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001399; cv=pass; b=ir2t6ubUox1KqunAkXrs7mFqpNm/0u6sbg0Ta6yUZE6La9uDxE5Ox1qlfrnU20YWKI4BAROXif78w+FZD2StYXqJrDYTtSPadaSyeaZcOYCoaLqmO3swrCHoR/woTiSXR6HFBAvKAouTDseuEKW6cH65/H053DbHs+oh8ARYbxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001399; c=relaxed/simple;
	bh=L7K5h9ss5itYa3PVNVnsJLd0vmUVmWWDUWKgAFHYFq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwyaBQpxaRiY01Dylt/bPy+IcK+iRPuCR9NgjXp72Yly0ocCMnC+gh1OGh/1cJdRcwLsH0cSJV7tz1t+LMGfIeUeyRNS9fWE3PIkqoi+RTOrMqPmgPqzAsDLLy+Fh7KcfHZp2vf24Lfbjk0k8qptpQINRqQBak69qHfpeo0hGj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QImxfmys; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QImxfmys"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-67109935888so2888072d50.3
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 07:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790001397; cv=none;
        d=google.com; s=arc-20260327;
        b=FbNmtqD25e+XLzzJc0cmSG+XzXegeyftTHHWbPvS58+J4E5OPKPUJsnOhUCcykQE7g
         yqoIfGFRLtKDnQMIgLYSRa2EKzWFEC8e/L6y2awgg9UoJhXglToillHM451am2eSAaLz
         rz9DkQk6l4FlsVP3kIL3JeZQPGeDTdbkx0kVhRBpVMuyXkZv31IdMSX9Ggg2QSAF9Dx6
         lOJs55KhxwMRSV88j1cZ5hts0gu/rKKjUPSi/fehN4eKI7RI82HWEx+72NTNgkK0JgWe
         TAetfNQiKxvs50sz8nKrqr5ewxWYTTpEnGmlPVbOJJJl5oNUWa/iQcrLqZUCjrKQci0M
         BcqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UQQaX7dLiH9spYaOUwUq19F+SUoVy4mqeHG1ly59DKE=;
        fh=UAevWC/91Z9BTIQew8vbd2LT3Gv56dNuE1GTXIxseCk=;
        b=aPodaK+PVyvZOgikAy/IFnqO6nOMK37JqIP/u/q2785oKhqMJrNDSH9nPk1xajzBmZ
         eb8A25xuafGtCFl70dbw+/Hc96uJOcxo/8NI8UvZ7Vk1K32OwPu55h3jwDXqlbnUZTFg
         7kxXpgEMXcd7yzBHZz8mBOSZSDO9gNHBFL+Dpv/MIsTxW6vw8q3yVSmMRPqLfPcb+YZW
         bZse/9jcpxiAqaXSI91VqtAfasMUFFfq7W6hKLgBobmpHYo19qjv6EP2Gmx5Arh36Ql4
         Y/UxqDGza5aH4IQyytJGxJESH4fn8jpstRrVV45oW0Q81hz+Kf+4VpaKUoS3bEFZeJPc
         QdRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790001397; x=1790606197; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UQQaX7dLiH9spYaOUwUq19F+SUoVy4mqeHG1ly59DKE=;
        b=QImxfmysaImtqZ+ui3x9VJPDG5rBcvcV46keBb06SfHfbPH4+bbxaJKw1ZGNQdiy5x
         ddqyuT3VOB1jZRsv/13myxMX+H77tz/cL+Jah+OXt62LmgTxoawRj6QF7MkNN1dz93Qo
         D2iq/giyHgOwsSy7j3aXKwSSJAsrtzCoSR2PV/oOy1KQRem1F7nChx8BCgRDrWhCIvEX
         HDKim0r6qIQrMVAglgTzh78bsbduMAUvqnsTyQr/KzASi2RtbzNhOD2MiBk8Kj2fqsrP
         YyQXYq78vsBJXEJTdu3dD/eYJGgA2vxFFpuCedi32xi16kUyoREG0B6YvndItrk7WiAR
         //1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790001397; x=1790606197;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UQQaX7dLiH9spYaOUwUq19F+SUoVy4mqeHG1ly59DKE=;
        b=AxrjPuyX4fLTEs7pf3vXSFI8pZ4lmDliyy0M60rmbqdW462IriWYCOx+IkBh7oPywI
         GZs2Jb+opwMJj7LWtYjyjY5q5+JISOj4aHtzZZwXt59SYNp1u8s0J6g2PcDTcXxj1SKI
         wduOW9Qgc+02g7/u3hedfWDwdfnrTWY0OxaWy91k915lRG0rKMNPmWK/uTpabGVX9Czl
         KGHAq/CSRVNji10WsfHlE8jMG/0IOgQw/SKq9DDkZwtKNCPkPQbbMeE25uh5gsqrQh1I
         cdF+iJ643V/No3VE/M2VjJ5YwJRuK5888QltcO6JCXO3CbfbSYA3Ge7oPM/0Gvd3GAAh
         pHSg==
X-Forwarded-Encrypted: i=1; AKwUvBwyGRPwsXloly5jkgVYZazsjWovggTN0523WIpTo6tx2XcuJgdSz+wGq55Mcdu5VUcvfXp8iBg=@vger.kernel.org
X-Gm-Message-State: AFuF++lNRcJqUvNs3JZbBdT73SCDYsySH8L4IyIQRnE2zR5fO7KRAHkT
	XWfDEZbuGJYcminum5Eoj0jEIex2AI/RYFETOuHPYpUDRLsbxmObcQyzlVC8vxIJ9Gqg9biwyly
	Cd9oSyhK9Q41Ako6M+fdeR6hxmBZrPbk=
X-Gm-Gg: AYBFou1t6eFnJq4ndaP0w8BHI01nWtJBWkGczPLlszaNYrksF/Z/XkwbjBnfNH5BT+W
	dOEsgWuIoGVAJlEABlpJC5Ut6UjnDIqK3uHRjbj53oYDzWSWJlG1SB4zNEHIrPlRxqQ0zaEP7Tk
	nzvNb/s5DvvppOYsdxfMF6wKwo50rSc85aeI6RKOthbIaeMkiStWOdgV7DZtQMs6MtJ7twqeMfy
	x7MfpwrOUIZAdjy3Alc9ISVLNr/NzlPOjQA1CnKF1zqjkz/BCBiJ7bvmkShBIQYp5otOEzr4eOY
	HkDhMgVGXS5hoK/zmxtyK4b07V21aPk76eI8NWnb7zOTJcJ+EA/tAviS7A==
X-Received: by 2002:a05:690e:43cf:b0:66f:ac49:a27a with SMTP id
 956f58d0204a3-6717fc65521mr2383542d50.14.1790001396949; Mon, 21 Sep 2026
 07:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916051618.2904439-1-lgs201920130244@gmail.com> <178962811102.1264013.13698060411191875408@gmail.com>
In-Reply-To: <178962811102.1264013.13698060411191875408@gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 21 Sep 2026 22:36:24 +0800
X-Gm-Features: AcwNN1VX0XaLkydRZySUPzjNak9mjroYac8VQM-fZ7BBkk7Judurvc9M8LXCNAM
Message-ID: <CANUHTR9Csn86KgVMTCBPBobAjg78-M3TR1VTz--yLyG74w6YbQ@mail.gmail.com>
Subject: Re: [PATCH] net: mediatek: fix PPE resource leak on remove
To: Wayen Yan <win847@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Wayen,

Thanks for the detailed review.

On Thu, 17 Sept 2026 at 14:55, Wayen Yan <win847@gmail.com> wrote:
>
> Hi Guangshuo,
>
> Thanks for the patch. Calling mtk_ppe_deinit() from the remove path is
> the right direction, since the probe error path already tears PPE down
> but the successful remove path currently does not.
>
> However, I think the cleanup is still incomplete.
>
> mtk_ppe_deinit() currently only destroys the per-PPE l2_flows
> rhashtable:
>
>     rhashtable_destroy(&eth->ppe[i]->l2_flows);
>
> This only destroys the hash table itself. It does not free any entries
> that may still be stored in it. In this driver, L2 offload entries are
> struct mtk_flow_entry objects allocated by mtk_flow_offload_replace()
> and inserted into eth->flow_table, and bridge/L2 entries are also
> indexed from ppe->l2_flows via mtk_foe_entry_commit_l2().
>
> There is also a lifetime mismatch for eth->flow_table:
> mtk_eth_offload_init() initializes it, but I do not see a matching
> destroy/free on the remove path.
>
> So I think remove should first drain the offload flow entries, using the
> same per-entry teardown as mtk_flow_offload_destroy():
>
>     mtk_foe_entry_clear(...)
>     mtk_wed_flow_remove(...) when needed
>     kfree(entry)
>
> and then destroy eth->flow_table and the per-PPE l2_flows tables.
> rhashtable_free_and_destroy() with a small callback would probably fit
> this better than plain rhashtable_destroy().
>
> While touching mtk_ppe_deinit(), it would also be better to use continue
> instead of return for missing PPE instances, so later PPE instances are
> not skipped.
>
> One more minor cleanup issue: mtk_ppe_debugfs_init() creates the ppe%d
> debugfs directory, but the PPE teardown path does not remove it.
>
> So I agree with the fix direction, but I think this should be respun as
> a complete PPE/offload cleanup rather than only adding mtk_ppe_deinit()
> to mtk_remove().
>
> Thanks,
> Wayen
>
Agreed. I'll extend the cleanup to drain eth->flow_table with
rhashtable_free_and_destroy(), using the same per-entry teardown as the
normal flow destroy path, then remove the PPE debugfs entries and destroy
the per-PPE l2_flows tables.

I'll also make mtk_ppe_deinit() continue past missing PPE instances and
send a v2 with these changes.

Thanks,
Guangshuo
