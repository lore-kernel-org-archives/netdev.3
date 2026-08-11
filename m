Received: from ixit.cz (ixit.cz [84.42.129.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D95379C34;
	Tue, 11 Aug 2026 18:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.42.129.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786472588; cv=none; b=luwUpMfjzSwFjHrV40JQsXNRrYXBVpdnteTzpqTKQMeCcDmsKJiNE006xUClwyr/zriNzjrE1WjphwPQ7xJOxkjtjlezGACTZF1k6IZW76ws4qfrLHFrsbRyH5zchxtHgFlgrQvcOJNWkVw4GctSWxmsUfo/FNR6rBJ7Jc2JP8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786472588; c=relaxed/simple;
	bh=J/JCNI4JP6PWEbRIaV+blSlUD3HtyB5zPYznoBNF450=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=miik5txC9XhZWUVJzZqrofVcph8HS4h0U5CEdg1XnR0L85vopu/roHiFqbCKb7MzePk+HX8pJ5X6o8KsNIUkCoEgddjxJK125aJI87BW8pUT7qfGDPilJ3Ex/VgdSWejtpk7t60fBLyVIUVq7t+o2hf4+LiG+xTR0n2ikb7svlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=G3bpCv5R; arc=none smtp.client-ip=84.42.129.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="G3bpCv5R"
Received: from [10.0.0.152] (unknown [10.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 63CE35340428;
	Tue, 11 Aug 2026 20:23:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1786472582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cXekTso0NmY5vetFykSsR+sNuU02JTTPlPjx9kOlbjs=;
	b=G3bpCv5ROsPgEgJnQZtZYY4QbSi2bTonB+6hwgvi2rni9A/QnHD6ATN69bpeacMWkIg2a1
	j22XK9+nldKXA9y4206lObrHhNfF7rMais7TnlK8x4oUBbWV8zp0fvxvPANKbM2b0WQWoZ
	YCz6wK4wmBlsipsx9W8wCT4n0S/cT1w=
Message-ID: <8e5c2ea4-53fe-4dd5-ac71-5bb3ab5ee911@ixit.cz>
Date: Tue, 11 Aug 2026 20:23:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] nfc: nci: Fix conn_info use-after-free
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ian Ray <ian.ray@gehealthcare.com>, Joe Damato <joe@dama.to>,
 Kuniyuki Iwashima <kuniyu@google.com>, Kees Cook <kees@kernel.org>,
 Ashutosh Desai <ashutoshdesai993@gmail.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Deepak Sharma <deepak.sharma.472935@gmail.com>,
 Michael Thalmeier <michael.thalmeier@hale.at>,
 Christophe Ricard <christophe.ricard@gmail.com>,
 Samuel Ortiz <sameo@linux.intel.com>, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260723022407.3402916-2-sanghyun.park.cnu@gmail.com>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20260723022407.3402916-2-sanghyun.park.cnu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/07/2026 04:24, Sanghyun Park wrote:
> nci_tx_work() looks up conn_info from conn_info_list and keeps using
> that pointer while sending queued data. nci_core_conn_close_rsp_packet()
> runs on the separate rx_wq and can remove and free the same conn_info,
> so the tx worker can dereference freed memory.
> 
> The same lifetime rule also has to cover other conn_info_list users and
> the direct rf_conn_info and hci_dev->conn_info aliases. Protect
> conn_info_list and conn_info pointer aliases with a dedicated lock, use
> it while publishing and removing entries, and keep readers under the lock
> while they dereference conn_info or copy the fields they need.
> 
> In nci_tx_work(), take the lock only around lookup, credit checks, skb
> dequeue, and credit accounting so close cannot free conn_info while it is
> used, but transport send latency does not block rx_wq response
> processing.
> 
> Fixes: 736bb9577407 ("NFC: nci: Support logical connections management")
> Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
> ---
> v4:
>    - Guard hci_dev before clearing its conn_info alias during teardown.
>    - Reflow lines flagged by the netdev 80-column check.
>    - Use the current NFC maintainer address from MAINTAINERS.
> v3: https://lore.kernel.org/netdev/20260630071717.3618185-2-sanghyun.park.cnu@gmail.com/
>    - Add Fixes tag for the logical connection close lifetime bug.
>    - Add the missing NFC maintainer and oe-linux-nfc list.
>    - Cover all conn_info_list helper users, not only nci_tx_work().
>    - Protect direct rf_conn_info and hci_dev->conn_info aliases.
>    - Publish and remove conn_info entries under the same lock.
>    - Protect RF conn_info discovery publication with the same lock.
>    - Keep HCI rx_skb immediate dereferences under conn_info_lock.
>    - Narrow nci_send_data() lock coverage around skb queueing.
>    - Avoid holding conn_info_lock across nci_send_frame().
>    - Use spin_lock_bh() so HCI timer callbacks do not take a sleepable lock.
>    - Keep conn_info_lock alive until nci_dev teardown instead of destroying it before nfc_remove_device().
> v2: https://patchwork.kernel.org/project/netdevbpf/patch/20260610081657.686636-1-sanghyun.park.cnu@gmail.com/
>    - Replace flush-only fix with conn_info locking around tx and close.
> v1: https://patchwork.kernel.org/project/netdevbpf/patch/CAOrxSK5UmFFfzdRG+P89+E+Rvg_1DmOvTs+M7353Q8=hkPXmSg@mail.gmail.com/
> 
>   drivers/nfc/st-nci/se.c    |  16 +++---
>   include/net/nfc/nci_core.h |   9 ++-
>   net/nfc/nci/core.c         |  98 +++++++++++++++++++++++++--------
>   net/nfc/nci/data.c         |  68 ++++++++++++++---------
>   net/nfc/nci/hci.c          | 109 +++++++++++++++++++++++++++++--------
>   net/nfc/nci/ntf.c          |  23 ++++++--
>   net/nfc/nci/rsp.c          |  52 +++++++++++++-----
>   7 files changed, 271 insertions(+), 104 deletions(-)
> 
Hello Sanghyun,

thank you for the patch, LGMT. Could you please rebase against

https://codeberg.org/linux-nfc/linux/src/branch/for-linus

There is a small conflict in the rsp.c

Thanks!
David
