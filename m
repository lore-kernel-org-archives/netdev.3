Received: from mta0.migadu.com (out-61.mta0.migadu.com [91.218.175.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA073446A7
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 01:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790560479; cv=none; b=n8dpf+xneMZV/u67x/ESMPcaNxE71t2I+HHSLeps9MSNg7oMbJGKalgRi/Alr9jjadd4PvBYcE2gtgOPGf+tQF9iKIhLlObRT2CI8UqtvUeBSoDGg+Fx7U2MKqZmo3mSthnLe6nDDkrNfgejuV9EWXlXmtRhmMx+dg815OZNGTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790560479; c=relaxed/simple;
	bh=w8pmFGrWPuuNi5jQAP7vT3tqKT/JOWUSxE9OiA65u3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8gR+NXfl5cCIYpFJU3dblqrsUZdBlpPTyA/IAvO5rCEf96YMtgJEK6NP+FSNRiGPg3hdX5YF9QzhtSJ9LwGvTfSXQYLd14Jj71g4dTggVI+3kkTUvcJr5ZNqA4+PK81rIXsNjYPxUV+99PWVV2bTF4akMoGI8NsvrulGPgkOSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GwmOLsdy; arc=none smtp.client-ip=91.218.175.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GwmOLsdy"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=w8pmFGrWPuuNi5jQAP7vT3tqKT/JOWUSxE9OiA65u3Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790560475; v=1; x=1791165275;
 b=GwmOLsdyL64bXd6jdG9pJ+xRhlkHe07JcVjN2JQyMMAOjnX5qxZ0xpoqWXwhr5BoBt8vjf2r
 pclyFFbvQa26VGeyaN20DjTEX41Fb7z60OL8TJh59Dd4Vi7DFxkF+T8Z25MrZyhtHj8v3mOgQ5g
 B56IR29kac4kgUcNxHW/Yi5o=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 52cfff9f79659a3b;
	Mon, 28 Sep 2026 01:54:35 +0000
X-Mizu-Trace-ID: 52cfff9f79659a3b
X-Migadu-Flow: FLOW_OUT
Date: Mon, 28 Sep 2026 09:53:52 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Danielle Ratson <danieller@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jonas =?iso-8859-1?Q?K=F6ppeler?= <j.koeppeler@tu-berlin.de>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH net-next v2 8/9] netlink: specs: tc: fix typo in cls-flags
Message-ID: <arnINjSI8OuGSFxc@fedora>
References: <20260925213918.204767-1-ast@fiberby.net>
 <20260925213918.204767-9-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260925213918.204767-9-ast@fiberby.net>

On Fri, Sep 25, 2026 at 09:39:11PM +0000, Asbjørn Sloth Tønnesen wrote:
> Fix a typo in the naming of a cls-flags constant.
> 
> The correct name for TCA_CLS_FLAGS_NOT_IN_HW is "not-in-hw",
> not "not-in-nw".
> 
> CC: Jamal Hadi Salim <jhs@mojatatu.com>
> CC: "Jonas Köppeler" <j.koeppeler@tu-berlin.de>
> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
> Note for Sashiko/Clashiko: Targeting net-next, so no "Fixes" tag.
> 
>  Documentation/netlink/specs/tc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
> index 2e663333a279..b6ccc645b0e3 100644
> --- a/Documentation/netlink/specs/tc.yaml
> +++ b/Documentation/netlink/specs/tc.yaml
> @@ -42,7 +42,7 @@ definitions:
>        - skip-hw
>        - skip-sw
>        - in-hw
> -      - not-in-nw
> +      - not-in-hw
>        - verbose
>    -
>      name: flower-key-ctrl-flags
> -- 
> 2.55.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
