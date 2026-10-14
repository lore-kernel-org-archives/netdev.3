Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D8347F3A1
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 07:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791961389; cv=pass; b=BC+ohLniiicj6LEr/cjaVjdPqZNvblCmwTzW9FyZOWEWWZHj/2IAKjz1MiHkWPqK76EDVWQltRV+W7q6o5FA/Pz4y7O1YHE/US7eq3+fdxY9HmVpCBa5K/WVRDAiuGsE57S5XdedX40vmx/Hfk+Papiijk+M2uhcHs2APb8Uwl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791961389; c=relaxed/simple;
	bh=Ud7d+jdUaru10b3HibIT+ZW62u2wMDg2Dfm9yphCSkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VE3n1y+n/MdaRp1HRDv7V1OsdmETzlkUKHg95xd3ncPPD414wy5jGzYNkHsba2JcgwzaAbVfQ5KW0QaxOamKMmX4HbM9u7O9xWgspTcc0EeRpxhgGOYg0fi0SBhPxfHOqWj/F/NGTgXGjbwgrTSn+c8WJXuk59aGh75MXu3AQBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gB9c+slr; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gB9c+slr"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2db80fcdf8bso21511625ad.2
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 00:03:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791961387; cv=none;
        d=google.com; s=arc-20260327;
        b=B3lTEG3kqkqOHxJbmPrlQ9ihqromISKuKSIBdjsQwgGQDt+udHtyt4sreMoKOE4ZlV
         j5J/DgZ97O/MKtj+P1eJbFnzR/gimGifrwGpjD/fB84wCTrIMwTAsVf2LQPLVqkzUDFj
         xSo2LsyB4KTjwzHI72fWC5Zv3itBQaZkRGD15xmmrgZsu/rIDAm54mMarGA4jSe1w1EH
         JpkgPZevWVkz80+EpQx0WmmxUXBmDvy8AdBby6chu9RgP/p5VBU8zj1hg9dN+rf/Kaj5
         vXmAMsON4qY28dh5izSJhVot3wWZnmNHjF3wgZiJuZFsB4bvtvZQlxYzc3kzpbG691if
         OLkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0MwlNHKdSo4nXnWLlQ4Dp9Xnk4aopVocSeJ4O75TP8Y=;
        fh=EQGt0Q1bX+XypxWv1xNv7C6+PdgUgmP4QyGaYNISsD4=;
        b=R3akKatmr5OAj309mSr43HjEL+fBDeyhyY2i62i1BoT2+v7Ag1VyLtMS+uv8yOy840
         bXmaASThAGeMTDRJJK6GHvjuhHR4vFT/BcTXTcmMMLxbcXpwqpp9xuFRjJDHwugbmdVL
         ypsINietpk1Oy74O7f55KFhUfZ6O7/9Al2K6hEE1Zw97l3BZQx1g8kDQZTGf97a1L2fZ
         qHbgDOahMLYgQAjDSo1UvwNVCrTRA5UatekO0EkvtaAtQ5QWfDSRn++FD09thrGlb5KG
         cloFe0dOtTcx3zYCaVp81evnSacj9IT/3EAL0VxZAbHzCBRUhr3VIZN8v5iiKemuN1Fs
         5odQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791961387; x=1792566187; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0MwlNHKdSo4nXnWLlQ4Dp9Xnk4aopVocSeJ4O75TP8Y=;
        b=gB9c+slrhil/FtEFcs1bjGlNYtk1PVnXTWvhUaaJYolKcvS0FgMC8g5d1p4KqhX3ZQ
         UKtbBp8UFJZV8ArUMYe3h3HJI8dH94v8/neTpUSIG4FXYWeqGp3JERJduphOcVO4fyOE
         Ip/8BpZ+eFPXDS4DRXsrB2RiZTJ9BcAEnDGt/brx2AhdCgh+bDy19VtSrMUCNyTBS1hu
         ry3UfqsfRR9F40QoyoZMmfmaKWvUZ8phHbfhpGYYwYiGQ2Q+bXH4fkNCWUPdZ5JDC8FB
         BF+DsDshiPelc1D1Ed2GDkuTfzbadTg4KypTeDzChjun0ytC8PSHMqpzmY14bPGPZg0+
         YMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791961387; x=1792566187;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0MwlNHKdSo4nXnWLlQ4Dp9Xnk4aopVocSeJ4O75TP8Y=;
        b=ikYR/ocSH5YtnbkwgmFzS+OPuz0L0QGcIIZvoZwvFrRqgt1zZSuribsy0Wji5diAJo
         iox5SL/5XHNeOlO2K6mEMf7M01mz1ahP+4dBfWXWpIs1mjkdw0vqiYb14HAK4hGLNxzY
         EHlWT6CtbjOEjqPKVVh03bzq0NnAWIMlXOpU3ntxcAjK46b2WXSdZsDLa3otgFvrZwjs
         l6o17MXQvZ/5sk2OBKq95SiIx9rEuzE1BYiEOHw1+A2dO7sRo9OGLjV4IfZ9hYZSphlu
         YPscI8EBfNB1n8v0ow9uR3fCUZzum3Laqp8jqIPxhg8EzudV2XMEoUSkhIhy4CDEmKVh
         GTeA==
X-Forwarded-Encrypted: i=1; AKwUvByxia5PqqerVVKVeXtWJMLkWB3gWttouTzJ+cdKq47AsreMmyOgkOZ/+tscFBvhjM0DeUENeaY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0wUVj9m/0hEllhSyPemlJeH6tQGzIWRtThcCEuge6WVxTFHpS
	NCTutD/Y6eOibrOf2UT83eIEA/3FSvie5/2rMSKU+yVblv1RvlP7MAxWZFR3wiCEFrznXlBljfL
	a4Eq1aYChmiz51qetPuk+sy6GzOZuuxU=
X-Gm-Gg: AYBFou2tEEP7/VLUeQOJ+sJLuFCyD3jM8lSPLnTmFbdrgs3V96hxeOKR+HJWZr+HEA+
	4MjPwzC9UC1SMrDq/CjYziZPc++kRg892F7xyk874CyfvJ0j3utLmh3zd/diZeaHngFPPaDmeii
	zBL3rDh3IOo8m6zsApOAAi/nZ8icp6Fa0ObnOOtbUamaBVyUJniTMxHkDWna12kU9uwAvMGYOQq
	hBiRsQxbG3ru1erVatjUNlyP9NVfGBVcgg33NnpKKBTQIwLgdP+nfvNbqm4pcINcgJBIxJ059Ac
	/4877DAWoaIiD5iTN1vc7RVgEmhUiRbzt4XTZr4THZMMeTmbZmF39An1/SEtQ9o9DkxQ0hhgrIo
	Wl08dCax7h9nNbxra8UpCU6Olk8xBdP0mPBYCsZU6nqw2AbLvhuOu+1p/gWO4rOUDUWIEoLhmx5
	EWWQ==
X-Received: by 2002:a17:902:ef44:b0:2dd:c100:7cbb with SMTP id
 d9443c01a7336-2e842bc6930mr116984155ad.55.1791961386763; Wed, 14 Oct 2026
 00:03:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007104731.507647-1-phucduc.bui@gmail.com>
 <179154290727.434549.17639920596465691112@kernel.org> <0040948f-abdc-4967-ab76-02962e813dee@redhat.com>
In-Reply-To: <0040948f-abdc-4967-ab76-02962e813dee@redhat.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Wed, 14 Oct 2026 14:02:55 +0700
X-Gm-Features: AclHuK-0C-Rz8o3BhYBcI4Pmv1zXl7KQ4Jjg3YkRJFwwpTufB6vgECVvJcL4egw
Message-ID: <CAABR9nEMcLxEAMCJmKGXzbbq50QGK4vHf30f5JpCc2ZVVvnGAA@mail.gmail.com>
Subject: Re: [PATCH net-next] smsc911x: propagate reset GPIO errors
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev-bot+sashiko@kernel.org, steve.glendinning@shawell.net, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

Thanks for looking at this.

> > - [Medium] net: smsc911x: clock reference leak when regulator_bulk_get()
> >    fails
>
> The above is IMHO worth addressing.
>

Agreed, the leak is real: the regulator error is saved and returned
after clk_get()
has taken a reference, and smsc911x_drv_probe() skips
smsc911x_free_resources()  on that path.

Since probe fails whenever ret is set anyway, the "try to continue"
comment is stale.

I plan to respin as a 2-patch series:

Patch 1:  returns early when regulator_bulk_get() fails, so no clock
reference is held on any error return:
--------------------------------------------------------------------------------------
ret = regulator_bulk_get(&pdev->dev,
                                        ARRAY_SIZE(pdata->supplies),
                                       pdata->supplies);
- if (ret) {
- /*
- * Retry on deferrals, else just report the error
- * and try to continue.
- */
- if (ret == -EPROBE_DEFER)
-         return ret;
- netdev_err(ndev, "couldn't get regulators %d\n",
-                    ret);
- }
+ if (ret)
+ return dev_err_probe(&pdev->dev, ret,
+                                     "couldn't get regulators\n");
...
- return ret;
+ return 0;
-------------------------------------------------------------------------------------------


Patch 2: is the reset GPIO change from v1, rebased on top of patch 1.
The "if (!ret)" check is no longer needed since the regulators are
always held at that point:

--------------------------------------------------------------------------------------------
pdata->reset_gpiod = devm_gpiod_get_optional(&pdev->dev,

       "reset",

       GPIOD_OUT_LOW);
+ if (IS_ERR(pdata->reset_gpiod)) {
+ regulator_bulk_free(ARRAY_SIZE(pdata->supplies),
+                                  pdata->supplies);
+ return dev_err_probe(&pdev->dev, PTR_ERR(pdata->reset_gpiod),
+                                    "failed to get reset gpio\n");
+ }
---------------------------------------------------------------------------------------------

Does this look OK to you?

Also, as the review suggests, both patches fix existing bugs, so I'd
like to add Fixes: tags and target net instead of net-next for v2.
Would that be fine, or would you prefer to keep this in net-next?

Best regards,
Phuc
