Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD83943F4CD
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493425; cv=none; b=mOWPNo8bPtzgwCoai2pDdFyBpyrxR4uu2EygtUHWVrCJos/cwld2peAT5hnepLoA2wPMK7exC1YdpQoOJBzV6Vam9VC45NzydI4JHKfxRHgT9jfDPDCzsdrYhMlzZNlOAckLqeioUxdiWitUcfNoKK0cacyO4GhrCbOAi76HgBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493425; c=relaxed/simple;
	bh=yldyXc+k9IUGHFBVvbXY7100U73O47dmandGyjhHpkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tP9pQs+JHxo0Y5RKXK9MM6T1DnRSkzafah63OPf3ytHPMgXzvBpIBHdukj4gXAciKW8VkYum+P+JkbtL4AAQSepNeXQDK6DGPJgaRE3qPUSS44n4dQ/Zsv/KbCI5xvpq/LyM+Eup0KGp3V/wswwoXyRHtbkEMozSr+WTvlPy3p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=pujhKfnY; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="pujhKfnY"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93e503815adso280761785a.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 14:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791493415; x=1792098215; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jtyJNESs2NfaCrmwRAvvPnxlfOHCunirXFuek+zM5MM=;
        b=pujhKfnY6XpqvzazTMREHza7p4Ap0e4jXF54QAp/Ylj9eUsbZRnO8OP3NEjY5Fvqo3
         8kMI8mbVFhHWPPvySjc1pQLaP+ny3PCVvXAL4V6q7bb8OK+0ASMiaXgmvoIRIXA8Grwe
         FexMoCArOtOy/6geShmDaiRqC4j1giTROp5AS6hGimHvv9C0Jjhg0uoribobV888EV62
         sSzFU5nziXYyYu590KlEhLUMYY4qwQTM16VryFW/h8z+CgqW4XecUVfVnZuzUBQoPyKt
         sLd/RqCYENJKXt5j77nLpxsDAPhp+GneOiV19SEX0UPVSduLLa2RTHG5NX6IfrRp6sa7
         X/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791493415; x=1792098215;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jtyJNESs2NfaCrmwRAvvPnxlfOHCunirXFuek+zM5MM=;
        b=JuZ6iQZhogOyNX3rozPto8iU/SbNocuIRVZCr8Asfl8siRO2ON3cKGyrnKSAcQfuSy
         xo6oVyKXf5IFLsV5WOuOO63gOOnbimNf+5PFSKxs02Sx2DurpRmPQTQ03UMyC4BgxQ2a
         HeCbRt9664IOdQI78ZuP29NdUQq6vTfWyKQgBPxAZkitSYkyrxhLDoRH0Pxs0D28ZjmZ
         LJNe6SMxItqoqCwbcGHQn86GOofLugtoKT2kKImhO34jVo7s5zEFONkASP2KIpD+384L
         Q4fdM/lVjIzKvn2aMXMICcHbn4/eRKBPzTNlwTOUkz1LbaRvj+4hd5xZ5l02hSKzwqKQ
         0z7g==
X-Forwarded-Encrypted: i=1; AKwUvByYZ1iqBy8xbNwIJoSChWGRnPzTSjMn1jhKcejEydvHl+tFu3jgqg2HF+VMcHzYB7h73lIqxfY=@vger.kernel.org
X-Gm-Message-State: AFuF++msAqh4n/4738fPxNVkZlwliBP6+87sUbXQhgXuQLJE/sO3y8xf
	K+HeZWhQLMxJ8mBVQVLK08KNIv3qLpAQoc+VD5hrWvj+SU+x2mvVqZBSjo4NGU5yiKU=
X-Gm-Gg: AYBFou0RKk9l+CAuj5KbXeilExAxoae27SfkTEru/8OusjOohDnnjeT606X+HMUihfX
	yytvXMWub0+lS5zkxjbprDoXIkBlffJt+56s8vTab0b6xYG1qSrPKVChhSu3JQvjIoiXIdbKXHk
	p3d2gXEiniP0f3C9wQ0nF+qWCLBuML/RJjU5EHguUXxPk5Ru5WvG35N14WpHOiGsX3TQCR6Oltf
	V1H4aLxaXYJ6aTt1YyhBfKrUhgkvxKd/klQiyS1AOOSlJz501vy5EdzzvPkSWuQ7uh9c2nm0uR2
	KpDnMJVThpZdk3j8GpfmSKGrcZ3UGxouDCStNhEhWZjw43v2ZDvk1LaZK6yvTQ3ILnNQk9MEUG4
	Dux7kW8nJfWgPAmGHZzda3Ct2UnO6Hee4YhbEtmEXIQIiVip+nxxPa3QBzndHbPzTsts4VgCP9o
	8qRdJx/dpDAnyJn2x4iqI+O4QvEDMSUZfU53C8eriqnNQpohRbD4hf5T7MIZ/gExMjPRpP0ZcMX
	08+qJtVJcFfsWI=
X-Received: by 2002:a05:620a:4613:b0:934:ab73:ac53 with SMTP id af79cd13be357-93e9af42cd2mr1369444185a.0.1791493415593;
        Thu, 08 Oct 2026 14:03:35 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.241])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb986c0e9sm24158885a.20.2026.10.08.14.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 14:03:34 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 08 Oct 2026 21:02:53 +0000
Subject: [PATCH net-next v2 06/10] e1000: use pskb_may_pull() in the 82544
 TSO workaround
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-b4-pskb-pull-tail-drivers-v2-6-8f2bd9bee138@toxicpanda.com>
References: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
In-Reply-To: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Manish Chopra <manishc@marvell.com>, Rahul Verma <rahulv@marvell.com>, 
 GR-Linux-NIC-Dev@marvell.com, Shahed Shaikh <shshaikh@marvell.com>, 
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 xen-devel@lists.xenproject.org, intel-wired-lan@lists.osuosl.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791493385; l=1221;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=yldyXc+k9IUGHFBVvbXY7100U73O47dmandGyjhHpkE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QO2CfzCzBOeK9ZW88WGSv+B3RUqXFGdARFKgVlna7gjBWdR0TdJniqj/mr2mdJ20mJNMEnviLw3
 DiEJcfynbhAc=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

e1000_xmit_frame() uses __pskb_pull_tail() to pull up to 4 bytes of
payload into the head for the 82544 TSO workaround.  It already checks
the result.  Switch to pskb_may_pull(), which takes the length the head
should end up with and checks it against the skb, so this driver no
longer calls __pskb_pull_tail() directly.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index d7f5c6f16142..3a55b211f5a6 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -3155,9 +3155,8 @@ static netdev_tx_t e1000_xmit_frame(struct sk_buff *skb,
 				    & 4)
 					break;
 				pull_size = min((unsigned int)4, skb->data_len);
-				if (!__pskb_pull_tail(skb, pull_size)) {
-					e_err(drv, "__pskb_pull_tail "
-					      "failed.\n");
+				if (!pskb_may_pull(skb, len + pull_size)) {
+					e_err(drv, "pskb_may_pull failed.\n");
 					dev_kfree_skb_any(skb);
 					return NETDEV_TX_OK;
 				}

-- 
2.55.0

