Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C98D3FA5FA;
	Sun,  4 Oct 2026 23:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791154940; cv=none; b=EdaufDKGGUmxwn1nDN0BgoWcS/aoBwHOS/9Hti2fA6jx8x044buPwOFoVA81iIHAx86saosnaKzhuk7gpfM+CH8cnHATVwrGd7HAGEWvH+sWhujzsSp6ERjNkrduvhjRtdssPPU4qgp6ZnTO1Hmwg0TAQlWzLC6E+K8LN+Rovkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791154940; c=relaxed/simple;
	bh=lCNGoxfJ6gbt1h/Um0ZGsuSNQP8LhKi7UR+AZ9snesM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oC+lOp8+8GN8H09/UC3tEFOHC04mYDyMELdvOXhUXtYog002lTbHTziEFu0E9LIrywHKCIzDSXzjbE5Io//2zG+VNDoj7Equ+NuXweLvgSjA+wjCt9fduWiAZX1SlPdoxnWPDoC49tcOS4Tjb3rpF9SdvEoaFaRc4ZgDforbJDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhbicqdO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhbicqdO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22B41F00893;
	Sun,  4 Oct 2026 23:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791154939;
	bh=Ou3Kn/QKNAyotDEY9AYLl+dL3qiaOM0hudZA+OTObMw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UhbicqdOQSPNiVfEX3as78TLavcvunea/+iajgFE6+Gm49NS+Pwwx1M5yq8IklTgh
	 796cgYn5DzAMhRfDtNRosffN1zhhEwsai+XvDYMlAhcbSNR4wWNoiI7xV2MXiovczZ
	 JhKNze2NCrSlTYlh3XxyuBhQZzuNaqc4Lx5Uz2Zjtw28p1CJK1M/brsTVGn55+/xgZ
	 0RviHaBni6r6EAe01e8yQFaKoE47X0jTVvod86jciRqyK3qimu8XdzOazXnXxyibl1
	 xW8fgidFPHCijkVUIeHnEuLS82vufMwJ3wgFgZt+JswyRU2+/dwLIZoKTJ3UDkStnw
	 hDDPOSnNxzsEg==
Subject: Re: [PATCH net] nfc: nci: fix out-of-bounds read in
 nci_core_reset_rsp_packet()
From: netdev-bot+sashiko@kernel.org
To: omermetekaya0@gmail.com
Cc: oe-linux-nfc@lists.linux.dev, david@ixit.cz, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 04 Oct 2026 23:02:18 +0000
Message-ID: <179115493823.434549.14381250566135948269@kernel.org>
In-Reply-To: <20260930224940.725976-1-omermetekaya0@gmail.com>
References: <20260930224940.725976-1-omermetekaya0@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch breaks the NCI 2.x reset/init handshake.
- [Low] The new comment in nci_core_reset_rsp_packet() and the commit
  message both swap the NCI versions.
- [Low] The commit message overstates the impact of the bug it fixes.

--

nfc: nci: fix out-of-bounds read in nci_core_reset_rsp_packet()

This patch changes nci_core_reset_rsp_packet() so it only reads
rsp->nci_ver and rsp->config_status when the payload is at least 3 bytes.
It also adds an early nci_req_complete() and return for 1-byte responses.
With that, the reset request is completed for every payload length.

> nfc: nci: fix out-of-bounds read in nci_core_reset_rsp_packet()
>
> nci_core_reset_rsp_packet() guards with skb->len != 1 before reading
> rsp->nci_ver (offset 1) and rsp->config_status (offset 2), but this
> admits a 2-byte payload where config_status lies one byte past skb->len.

[Severity: Low]

Is "out-of-bounds read" the right description of the old behaviour? For a
2-byte payload, the only access past skb->len was rsp->config_status. That
value was only passed to pr_debug():

    pr_debug("nci_ver 0x%x, config_status 0x%x\n",
             rsp->nci_ver, rsp->config_status);

If DEBUG is not defined and the dynamic debug site is not enabled,
no_printk() never evaluates the arguments. If it is evaluated, the byte is
just past skb->len but still inside the skb head allocation. rsp->nci_ver
at offset 1 is in bounds for a 2-byte payload.

With the Fixes: tag, this framing invites a stable backport of a patch that
also changes the NCI 2.x reset flow (see below). Could the commit message
describe the impact more precisely?

> diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
> index b0ab4f5acbce8..e52956bf33de8 100644
> --- a/net/nfc/nci/rsp.c
> +++ b/net/nfc/nci/rsp.c
> @@ -32,16 +32,22 @@ static void nci_core_reset_rsp_packet(struct nci_dev *ndev,
>  
>  	pr_debug("status 0x%x\n", rsp->status);
>  
> -	/* Handle NCI 1.x ver */
> -	if (skb->len != 1) {
> -		if (rsp->status == NCI_STATUS_OK) {
> -			ndev->nci_ver = rsp->nci_ver;
> -			pr_debug("nci_ver 0x%x, config_status 0x%x\n",
> -				 rsp->nci_ver, rsp->config_status);
> -		}
> -
> +	/* NCI 2.x reset response carries nci_ver and config_status;
> +	 * a 1-byte response is the NCI 1.x status-only form.
> +	 * Require at least 3 bytes before reading those fields.
> +	 */

[Severity: Low]

Are the protocol versions swapped in this comment? The 3-byte response
(status, nci_ver, config_status) is the NCI 1.x form. The 1-byte
status-only response is NCI 2.x, and its version arrives later in
CORE_RESET_NTF.

The removed comment said "Handle NCI 1.x ver" above the branch that reads
rsp->nci_ver. nci_core_reset_ntf_packet() in net/nfc/nci/ntf.c is where
nci_ver gets set for NCI 2.x:

    /* Handle NCI 2.x core reset notification */
    ...
    ndev->nci_ver = ntf->nci_ver;

The selftest vectors in tools/testing/selftests/nci/nci_dev.c use the same
mapping:

    const __u8 nci_reset_rsp[] = {0x40, 0x00, 0x03, 0x00, 0x10, 0x01};
    const __u8 nci_reset_rsp_v2[] = {0x40, 0x00, 0x01, 0x00};

The commit message has the same mix-up in "The 1-byte (NCI 1.x
status-only) case".

> +	if (skb->len == 1) {
>  		nci_req_complete(ndev, rsp->status);
> +		return;
>  	}

[Severity: High]

Does this break the NCI 2.x reset sequence? The old code did not complete
the request on a 1-byte CORE_RESET_RSP. For NCI 2.x, the request stayed
pending until nci_core_reset_ntf_packet() had set nci_ver, manufact_id and
manufact_specific_info. That function then calls:

    nci_req_complete(ndev, NCI_STATUS_OK);

With this change, __nci_request(nci_reset_req) in nci_open_device() returns
as soon as the RSP arrives, before the NTF. nci_open_device() then picks
the CORE_INIT_CMD format from nci_ver, which is not set yet (it is 0 on
first open):

    if (ndev->nci_ver & NCI_VER_2_MASK)
        opt = &nci_init_v2_cmd;

As a result, an NCI 2.x controller gets an NCI 1.x CORE_INIT_CMD.
nci_core_init_rsp_packet() also uses nci_ver to choose the v1 or v2
parser, so the CORE_INIT_RSP would go to the v1 parser.

What happens when the late CORE_RESET_NTF arrives? nci_req_complete() only
checks req_status == NCI_REQ_PEND:

    if (ndev->req_status == NCI_REQ_PEND) {
        ndev->req_result = result;
        ndev->req_status = NCI_REQ_DONE;
        complete(&ndev->req_completion);
    }

So the NTF's completion would land on the next pending request, either
ops->setup() or CORE_INIT, before that request's own response has been
parsed. Every later request/response pair would then be off by one.

The NTF's write to ndev->nci_ver can also now race with the read in
nci_open_device(). The complete()/wait pair that used to order them is
gone.

The selftest covers this flow. virtual_dev_open_v2() writes
nci_reset_rsp_v2 and then nci_reset_ntf, and it expects nci_init_cmd_v2
next.

The commit message says nci_req_complete() should be "always called
regardless of payload length". Would it be enough to keep the original
completion behaviour and just add the skb->len >= 3 check before reading
rsp->nci_ver and rsp->config_status? A 1-byte RSP with a non-OK status
could still be completed right away, because no NTF follows it.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930224940.725976-1-omermetekaya0%40gmail.com
