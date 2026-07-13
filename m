Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DFA42B321;
	Mon, 13 Jul 2026 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949787; cv=none; b=dYcZIpbkE9xbbqOmZ/V+TwnId2G0RFlWsYxP34uCW2WkG359O9ojzg/Dg5LeiOqJq43zC/XqIdr5hcXhyXn/SAtbp/cgCjXzPSxA/xSqVXzkgkPnAxCVVliG0vIp3VQlni585tttku+YSaWhc7tvYaNi/kOz9zizENTNQmfaq/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949787; c=relaxed/simple;
	bh=KQaGjZklyXOL46oIWHAbvpKyrD5LOhE1uXXqc3I92SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHjtwvEZBH/F7fxhTbij3FLPaCvOwuR6niSXTlM1PbYrhBPIJgJd0xswIsMelpTf9xdN30uMwqL5/+ebW8MvarFVIOJsnC7KtI4EJBZ7kvzlGijodboXEzr/iQEvDdg+wxQrMTAehO5ItPDH5/+TGXLCTO7ZL5mYibbWy0xC8w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eerlGjvH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eerlGjvH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7991F00A3A;
	Mon, 13 Jul 2026 13:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783949785;
	bh=s6MkcBPdKLrgvddh1WFyAWTpNurDDwiIil/dsjVihBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eerlGjvHwK6QL3d0jzkAaVs2n1Bo5slZPHBWvYDx5JNAYb7PqD0ErAWeOkH9katJ3
	 qmwdQglbelj6xgNds7VuBq1th2gOEP6LxvGukI36+P0g65Pn06qiSvZa9Tc9EdKwYj
	 PpoceJ7m7N6YHD83ubMJkNln57Fjm8BttDtaeUL5xnEK6IYKDwnLXdsQe4WsAV9uqE
	 8i8k5SE2kYdI66HHhnuNdrbb/KAspsoN7IKUzEYJTW5gbmdmDP/dA4SZGvffEWyGNX
	 UoKR3th6WtBj+ba/1h1bDcHE/ohpZoWwa8OmqlBBuZqN3CdkA6jtJyyyNOskaxPBoi
	 6StMInQYckr5w==
From: Simon Horman <horms@kernel.org>
To: bestswngs@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	jmaloy@redhat.com,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hoang.h.le@dektech.com.au,
	xmei5@asu.edu,
	linux-kernel@vger.kernel.org,
	tung.quang.nguyen@est.tech
Subject: Re: [PATCH net v2] tipc: fix NULL deref in tipc_named_node_up() on empty publication list
Date: Mon, 13 Jul 2026 14:35:00 +0100
Message-ID: <20260713133459.1777719-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706163024.1205930-2-bestswngs@gmail.com>
References: <20260706163024.1205930-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
tipc: fix NULL deref in tipc_named_node_up() on empty publication list

This commit fixes a NULL pointer dereference in tipc_named_node_up() that
occurs when the cluster_scope publication list is empty. The fix introduces
an early return to avoid calling named_distribute() with an empty list.

> diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
> index ba4f4906e13b7..60ccaa862162c 100644
> --- a/net/tipc/name_distr.c
> +++ b/net/tipc/name_distr.c
> @@ -218,6 +218,10 @@ void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
>  	spin_unlock_bh(&tn->nametbl_lock);
>  
>  	read_lock_bh(&nt->cluster_scope_lock);
> +	if (list_empty(&nt->cluster_scope)) {
> +		read_unlock_bh(&nt->cluster_scope_lock);
> +		return;
> +	}

[Severity: Critical]
Does this early return prevent the transmission of the last_bulk
synchronization message to the peer node?

In tipc_named_dequeue(), the peer node sets *open = true only when receiving
a message where msg_is_last_bulk(hdr) is true:

net/tipc/name_distr.c:tipc_named_dequeue() {
        ...
        if (*open && (*rcv_nxt == seqno)) {
                (*rcv_nxt)++;
                __skb_unlink(skb, namedq);
                ...
                return skb;
        }
        ...
}

If *open is false, all subsequent non-bulk name publications will fail this
sequence check and remain in the namedq indefinitely. 

Without sending the last_bulk message, could this cause a permanent stall
of name table updates and an unbounded memory leak of socket buffers on the
peer node?

>  	named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);

[Severity: High]
This isn't a bug introduced by this patch, but looking at named_distribute()
called here, what happens if buffer allocation fails during the loop?

Inside named_distribute():

net/tipc/name_distr.c:named_distribute() {
        ...
        if (!skb) {
                skb = named_prepare_buf(net, PUBLICATION, msg_rem, dnode);
                if (!skb) {
                        pr_warn("Bulk publication failure\n");
                        return;
                }
        ...
}

If the function returns early due to allocation failure, the messages
already added to the queue are transmitted by tipc_node_xmit(), but none
of them will have the last_bulk flag set since that happens at the very end
of the function.

Could this also prevent the receiving node from transitioning its named_open
state to true, leading to the exact same permanent stall and memory leak of
subsequent normal name publications?

>  	tipc_node_xmit(net, &head, dnode, 0);
>  	read_unlock_bh(&nt->cluster_scope_lock);
