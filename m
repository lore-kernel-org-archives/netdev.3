Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566071;
	b=ploeMM3uggvycWCUHTVfiAvwcbdt6PDr6Zx5VuwZF6zmA+3GghK2OtmdM/a4ptNxT/KF
	 C3ft0lveqwi5Bt+NGsX74s+1mQKJQnnrbeFS8spD9fuVLQnpTOjmeGi3m0w5tZzouqSR5
	 ui9PkC4FJBtUFIjHiiPRnIiNId86kzE5jIEh/ppe7JVvFMXc5aRRe89pjcAB1MO0lr5T5
	 /Ro1C6y39Y1ZnF9yuRYzMh2fCVbv3oWIryTAE5T+9655j0HUFvDdT8T0Eo3rBOGGM7KZN
	 0g2r7DQJnzuEIGceXfCMc3luAYV/pY6yeMg/x/UENIDOZQT16Y86nPbiiwObLPCIwpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566071;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/YmEl9MFZJXUpvQcOVvvVL0ExNudpMN/SkBtuR3ZO8M=;
	b=BYPCOuHBbyqAjahJbepk7Ke9uEzt/6KZkvjwLBICtoUNhXtmNETc1VzP9CN/aaotnj3n
	 Vh7NrLjVbtp0LOMBXiPMjX87pIo938COHoc0Z+03oWLxvsqY/zsXjoJubTrZRoA0B4pbV
	 fJ/lR7bJzWWF1qqIlGTdT4cyhc/H3bWyxyhMY7F9YvhcEoiGLm+29NlU2wjDQWxSnpwUy
	 2mQCsFJnL0VBEavWtb/KiDNC2xPLSIYyHNVr8ded6twgCsIo1pnXkoqA/59ME2U9M+C33
	 gh4KTll6gJSnyVWvTNg8y8r7HoC6hcg3kgeVfSBAMVyMMN6jJlYN9jX9LMeHLMlsd/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYzvZ9Vu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0CA606A31C;
	Fri, 13 Nov 2026 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYzvZ9Vu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C621F000C4;
	Fri, 13 Nov 2026 10:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794566071;
	bh=/YmEl9MFZJXUpvQcOVvvVL0ExNudpMN/SkBtuR3ZO8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dYzvZ9VuqN0iwIV1Ntjt6pLlZGQ2VfvGi1FQqbo+ihEW+xZEUfxZy+H9+P3yObpGy
	 0f2LFRss025GXIfk/hZaHQpfPOg5T3Kf43WZpPfXhSvrs+DzqOLV8oCqyLm3P9hF1F
	 JfxAcP/aBjt2aNTbsvlUJksV9ED0PLbF5mtTU+76dxAiXln5RipbQEjP8ir0htc0+O
	 GhZWg9p8mD2smMhKo/FaTvcMJyMhHf5LhMSNVA8LYCkPao7yi4Q85f/Deyr2Bfis9j
	 1dN3BmStapfIYy8XmRI/YGCq0WXpXJnAiGGfm0zFeBG3jFkwIoro3/ZY7PZPOzpVjb
	 VVHsgM4PmZeTw==
Date: Fri, 13 Nov 2026 10:34:26 +0000
From: Simon Horman <horms@kernel.org>
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev,
	David Heidelberg <david@ixit.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thierry Escande <thierry.escande@linux.intel.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Samuel Ortiz <sameo@rivosinc.com>, linux-kernel@vger.kernel.org,
	yana06070@163.com
Subject: Re: [PATCH net-next] NFC: digital: fix target leak after Type 1 Tag
 discovery
Message-ID: <20261113103426.GK18859@horms.kernel.org>
References: <20261109031832.37642-1-yanxia@cmss.chinamobile.com>
 <20261113100007.GI18859@horms.kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113100007.GI18859@horms.kernel.org>

On Fri, Nov 13, 2026 at 10:00:07AM +0000, Simon Horman wrote:
> On Mon, Nov 09, 2026 at 03:18:32AM +0000, Xia Yan wrote:
> > digital_in_recv_sens_res() allocates a target for an NFC-A response.
> > For a Type 1 Tag, it calls digital_target_found() synchronously.
> > nfc_targets_found() copies the target into dev->targets.
> > 
> > On success, rc is zero and the callback skips kfree(target).
> > The original allocation is lost when the callback returns.
> > Each completed Type 1 Tag discovery leaks one struct nfc_target.
> > 
> > Free the target after digital_target_found() returns. Clear the pointer
> > to avoid freeing it again on the error path. Keep the target for other
> > tag types, whose discovery continues asynchronously.
> > 
> > Found during a code review of NFC-A target ownership.
> > 
> > Fixes: 2c66daecc409 ("NFC Digital: Add NFC-A technology support")
> > Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
> > ---
> >  net/nfc/digital_technology.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/nfc/digital_technology.c b/net/nfc/digital_technology.c
> > index ae6487c10a25..2d52e390cc67 100644
> > --- a/net/nfc/digital_technology.c
> > +++ b/net/nfc/digital_technology.c
> > @@ -510,10 +510,13 @@ static void digital_in_recv_sens_res(struct nfc_digital_dev *ddev, void *arg,
> >  		goto exit;
> >  	}
> >  
> > -	if (DIGITAL_SENS_RES_IS_T1T(target->sens_res))
> > +	if (DIGITAL_SENS_RES_IS_T1T(target->sens_res)) {
> >  		rc = digital_target_found(ddev, target, NFC_PROTO_JEWEL);
> > -	else
> > +		kfree(target);
> > +		target = NULL;
> > +	} else {
> >  		rc = digital_in_send_sdd_req(ddev, target);
> > +	}
> >  
> >  exit:
> >  	dev_kfree_skb(resp);
> 
> Thanks Yan,
> 
> I agree this is a bug and that you patch correctly addresses it.
> However, I wonder if it would be cleaner to confine cleanup to
> the exit path, centralising the kfree logic.
> 
> Something like this (compile tested only!):
> 
> diff --git a/net/nfc/digital_technology.c b/net/nfc/digital_technology.c
> index ae6487c10a25..94880172f016 100644
> --- a/net/nfc/digital_technology.c
> +++ b/net/nfc/digital_technology.c
> @@ -483,6 +483,7 @@ static void digital_in_recv_sens_res(struct nfc_digital_dev *ddev, void *arg,
>  				     struct sk_buff *resp)
>  {
>  	struct nfc_target *target = NULL;
> +	bool res_is_t1t = false;
>  	int rc;
>  
>  	if (IS_ERR(resp)) {
> @@ -510,7 +511,8 @@ static void digital_in_recv_sens_res(struct nfc_digital_dev *ddev, void *arg,
>  		goto exit;
>  	}
>  
> -	if (DIGITAL_SENS_RES_IS_T1T(target->sens_res))
> +	res_is_t1t = DIGITAL_SENS_RES_IS_T1T(target->sens_res);
> +	if (res_is_t1t)
>  		rc = digital_target_found(ddev, target, NFC_PROTO_JEWEL);
>  	else
>  		rc = digital_in_send_sdd_req(ddev, target);
> @@ -518,10 +520,11 @@ static void digital_in_recv_sens_res(struct nfc_digital_dev *ddev, void *arg,
>  exit:
>  	dev_kfree_skb(resp);
>  
> -	if (rc) {

Probably a comment is warranted here. Something like this:

	/* Release target on error.
	 * digital_target_found() does not take ownership of target,
	 * so also release target if res_is_t1t is true.
	 */

> +	if (rc || res_is_t1t)
>  		kfree(target);
> +
> +	if (rc)
>  		digital_poll_next_tech(ddev);
> -	}
>  }
>  
>  int digital_in_send_sens_req(struct nfc_digital_dev *ddev, u8 rf_tech)
