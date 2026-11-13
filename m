Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564013;
	b=f3tTfGnmrXLfnggYgxmNZbgrEb0ix4PZ/bwZ7AZ5QOM6i0QDvAOk0dTEWTxek85NW9lN
	 3hFYV+ERZxiu2lle25XWEf8b34xAB/lJ7dg1kjH19k5Gx0dkSwmSf7p/CPliVwbXb6nEd
	 gKc/4WTLNRbPiA1S2NXiJU7yn6AmHAvRkXqXFXH3daeQLJ9AY0BZnsLw2KyQypDdLfzDk
	 ZCULXvWXNl0uFV+4g01SWJgh11vBXfMmGKmIXJE8TlUFS2A3wEIoL1Iw7mXlx2HMRIZxU
	 KzmlPbfr0ioQw1chZKH5hGEi5IM9QTx6XS2XXtSOZRG6v0B4JnOu/ipWIBHY2ha6s9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564013;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CZEQVZ6TVB8PXZyirm0oWvsQKQ+yV93wdSIBjZmPOVw=;
	b=g7qzc+yTROi725US3HFRyDcq2IsgmyrGKRKgvXT/PnjCuUzxCH8vub0jEtyoeSdkUada
	 3qwyCnCUpzO7GLX2qWgRXv4mUjqbkSCRCtf2+Hdxj+j2hZCF+PbMFmilSN5rDu4hQ/Yaf
	 i23OMG4xsdZOyyYpr6kwAgvLqHeYCU3ZWj1rMy+aL2/EHWshUa+bzHy3sAs6THau9xOFw
	 Rz8vKBpmtNA7AfHUN1LDd/7tjTY3VgugR+MYnEYJW8HkP2JZFWolV4Syc8drU8b0a2x3h
	 Wc2g8bGPaGeWH04Fr9opaBmRR4JM8MuP+fKCxwCpzBJlxa0KdkqvxJWkONrqVeMdgRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ioh3c7+L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1232606A337;
	Fri, 13 Nov 2026 10:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ioh3c7+L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA301F000C4;
	Fri, 13 Nov 2026 10:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794564012;
	bh=CZEQVZ6TVB8PXZyirm0oWvsQKQ+yV93wdSIBjZmPOVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ioh3c7+Li4hBvBjUiWmNiOBUipdlGq9BrKY1Gllg/1pwHe4dGrEqLu5Eib4iKE9vs
	 UA9832q26rizKLXxFqb3g3RKIQUGWCCTjt+/s+xFwcTjDEEg3KR9dCESBg3O3OPw6R
	 C6ADhMfinEJvPopECOflU3BqH+WfjYGOqM3GKZ9Mb39gFdGTLUx+dYJljEcRcYp2hn
	 5f8AW0yrwbSj1r832w81nTXfJfKBtgE24MDxl5w1cLa3mmbQUJYbPgU+Jo1lrJ18m2
	 ghFcegLfOjleLF6tlNqaFnaN7YTQgvJceIomLGKtoE2Y6u2WKM19qo40jfINrRbA3E
	 ynOw0pUK1sf8g==
Date: Fri, 13 Nov 2026 10:00:07 +0000
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
Message-ID: <20261113100007.GI18859@horms.kernel.org>
References: <20261109031832.37642-1-yanxia@cmss.chinamobile.com>
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
In-Reply-To: <20261109031832.37642-1-yanxia@cmss.chinamobile.com>

On Mon, Nov 09, 2026 at 03:18:32AM +0000, Xia Yan wrote:
> digital_in_recv_sens_res() allocates a target for an NFC-A response.
> For a Type 1 Tag, it calls digital_target_found() synchronously.
> nfc_targets_found() copies the target into dev->targets.
> 
> On success, rc is zero and the callback skips kfree(target).
> The original allocation is lost when the callback returns.
> Each completed Type 1 Tag discovery leaks one struct nfc_target.
> 
> Free the target after digital_target_found() returns. Clear the pointer
> to avoid freeing it again on the error path. Keep the target for other
> tag types, whose discovery continues asynchronously.
> 
> Found during a code review of NFC-A target ownership.
> 
> Fixes: 2c66daecc409 ("NFC Digital: Add NFC-A technology support")
> Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
> ---
>  net/nfc/digital_technology.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/nfc/digital_technology.c b/net/nfc/digital_technology.c
> index ae6487c10a25..2d52e390cc67 100644
> --- a/net/nfc/digital_technology.c
> +++ b/net/nfc/digital_technology.c
> @@ -510,10 +510,13 @@ static void digital_in_recv_sens_res(struct nfc_digital_dev *ddev, void *arg,
>  		goto exit;
>  	}
>  
> -	if (DIGITAL_SENS_RES_IS_T1T(target->sens_res))
> +	if (DIGITAL_SENS_RES_IS_T1T(target->sens_res)) {
>  		rc = digital_target_found(ddev, target, NFC_PROTO_JEWEL);
> -	else
> +		kfree(target);
> +		target = NULL;
> +	} else {
>  		rc = digital_in_send_sdd_req(ddev, target);
> +	}
>  
>  exit:
>  	dev_kfree_skb(resp);

Thanks Yan,

I agree this is a bug and that you patch correctly addresses it.
However, I wonder if it would be cleaner to confine cleanup to
the exit path, centralising the kfree logic.

Something like this (compile tested only!):

diff --git a/net/nfc/digital_technology.c b/net/nfc/digital_technology.c
index ae6487c10a25..94880172f016 100644
--- a/net/nfc/digital_technology.c
+++ b/net/nfc/digital_technology.c
@@ -483,6 +483,7 @@ static void digital_in_recv_sens_res(struct nfc_digital_dev *ddev, void *arg,
 				     struct sk_buff *resp)
 {
 	struct nfc_target *target = NULL;
+	bool res_is_t1t = false;
 	int rc;
 
 	if (IS_ERR(resp)) {
@@ -510,7 +511,8 @@ static void digital_in_recv_sens_res(struct nfc_digital_dev *ddev, void *arg,
 		goto exit;
 	}
 
-	if (DIGITAL_SENS_RES_IS_T1T(target->sens_res))
+	res_is_t1t = DIGITAL_SENS_RES_IS_T1T(target->sens_res);
+	if (res_is_t1t)
 		rc = digital_target_found(ddev, target, NFC_PROTO_JEWEL);
 	else
 		rc = digital_in_send_sdd_req(ddev, target);
@@ -518,10 +520,11 @@ static void digital_in_recv_sens_res(struct nfc_digital_dev *ddev, void *arg,
 exit:
 	dev_kfree_skb(resp);
 
-	if (rc) {
+	if (rc || res_is_t1t)
 		kfree(target);
+
+	if (rc)
 		digital_poll_next_tech(ddev);
-	}
 }
 
 int digital_in_send_sens_req(struct nfc_digital_dev *ddev, u8 rf_tech)
