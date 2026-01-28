Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F799326935
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 06:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769582405; cv=none; b=iY7bS2Ns1jnG8bEQENFHMPTGSMX3mAYbmrbTbyt+BRIFmOCsrQ8isOefX2gGJzEmv1HpD5pfsFElw1PR3eOUHBetoNB7s2w+URS1SvQAcVsBWbO1M5vmRM462DfMIQ6/dHNxQKA50m+VgDsNEfJXDDa6AC3R618Gljg8VRi8zRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769582405; c=relaxed/simple;
	bh=E1K2pHv7CdHHaErG/LHj07Gj/ZAUN+x28jbA4fK/zkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkiMVjfPIUrEkMkOhp8L4MZYhs0DNUTdisLC3oL68LUmr4EiIT9ZaoSStme1TvApxq2+XU9/SqQGlVct3a9JR+q+tJfdCYrnWPtb8FG3R5ezl5XpIBxWefcm/wCGBKk/7tvAXORLkcWN9WIXKiVqhxp4LVN35uAJmz6vY4a3uq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hAa+Fr+B; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hAa+Fr+B"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0d67f1877so42462935ad.2
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 22:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1769582403; x=1770187203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oBDlGkVRzBAscoMa27HQOY++Xo9LBKAiws3Dk5auGW4=;
        b=hAa+Fr+Bn08jrlK6TYZHrrdiDorO5oSXxJozLmyc8OSdfSbxDpaPg1PQ2EfEbLo1q7
         WPFVfoPQQvY8xMOE9n8pqZLG0t2G4ReIjC0Wxr7Z8G484SB40mjZ4QsTWoGNp3XZaB2c
         70DI8S0p0UenGep75OsKJysWOYQyKHAJijdxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769582403; x=1770187203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBDlGkVRzBAscoMa27HQOY++Xo9LBKAiws3Dk5auGW4=;
        b=M0RRUX0RbgQEGCaQ17lH6qEDNyT4zkr+3eS2zTWfh9IGDwP1GFxu6vf6JboFx86mAZ
         Ryx5F8f4utC6HMR27ygwitOfHJVk4p8AeKAfrLPapcc5HdieHcssbbNbJ554VhWgJCqY
         YkSXVY7Sp/c1hVXHE+FACyfmyohDJqKQ42iNPiY7cv7z++DnqxTyeE+CcKNLMgwgEnlf
         Tya0XgK90OVWTRX4WDv91fEjEEkS0dInRC22Y0vVrs3QjvIPFSt4KDj0r9Sv+Xg4lzpo
         kgdcanip6V/71X/F3YqrdMVU/YSSFoDZa55CvJQEe2kwcK490u5G7CfgZxV0bJ1dg4nl
         4T/A==
X-Forwarded-Encrypted: i=1; AJvYcCWMjAGv6zoNuf5SVOMpG67ItzaHhF/CnQmhim4ZZHogIPp6qhi2cGUhcajEkCpmX0YPlzfG34Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwqGq9EPkWNrtZepjsbleDD1raXrq09mwDGCU7iLSCt7gKwPNy
	TCtupHD79gqz3sarIcDn7WhYR2vTYZdbwUSuIVeNlHc3YCdApMWb9gnJl0p//PSOLQ==
X-Gm-Gg: AZuq6aLKqe0EiugkvuS220WyMfLdTyexftTxfedvxyARiTLe65kpUGfbH+njsYBxngK
	0EsjFQML2nAsO9QOAprZ3ysIl5ECmKxZ64m8zlpgkdVp1BqOr5k3LHg2Vts3henfYtn4tsfq3dd
	GgMXuVfE4SciWSDUerH2ChXlye3gcDM8A7Zy+FfufCA1hQHKrbwaP//lHAZGbpGzNRBc7cmazyu
	naeZrTDQ0mh0HkJG/cPArsi9trmiBXbGG6Voq/yaeUGo4f1bUH+Q8G8utPFsKKApioqurQhUelv
	8Dr8GGPCvlN6IMsRexha+atW/4xM3Es+dWVynDP2s9+h4yTS9XPb9L3IXxK2+oxuYhTSgQn67Tq
	1ukJMknyhewvoJHfC56OpNXkK1+lnQsuflwptnaZHONT9xTk0YelYHjME6crU+vLFebCQTt9S/B
	Z+AwLa5cAtpDNScbj8x/gxguRwOHRn3/WOtZTwxKIedaTeuUqzWA==
X-Received: by 2002:a17:903:1a2f:b0:2a8:7814:47d0 with SMTP id d9443c01a7336-2a878144973mr32768585ad.22.1769582402949;
        Tue, 27 Jan 2026 22:40:02 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:bf24:413d:1e8a:6aa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c3afdsm12277125ad.61.2026.01.27.22.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 22:40:02 -0800 (PST)
Date: Wed, 28 Jan 2026 15:39:58 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Realtek linux nic maintainers <nic_swsd@realtek.com>, 
	Takashi Iwai <tiwai@suse.de>, linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: net: usb: r8152: resume-reset deadlock
Message-ID: <glff4ejcf37b7avgqdmxbobujezchyyxhytpqoe2gskd4qlgoe@nq6tiutyc5qe>
References: <a4pjgee3vncuqw5364ajocuipnfudkjnguwmmvjzz3ee3yjxzs@zxldhr5x7dkk>
 <13903eae-7a61-44d6-8e54-1d3f85799f58@redhat.com>
 <whsdw44eikzzbzgzobfxxnbt2yibsqbm6o2dhrgmrbvr5srmkr@ic5em5ck5mcz>
 <fnvkmao3cfavr6gijb53h77wtk2nixjjhczx5wxnu7baypbdmg@elrzevwou7dd>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fnvkmao3cfavr6gijb53h77wtk2nixjjhczx5wxnu7baypbdmg@elrzevwou7dd>

On (26/01/28 15:12), Sergey Senozhatsky wrote:
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 30f937527cd2..c9406b89bb12 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -8538,20 +8538,18 @@ static int rtl8152_system_resume(struct r8152 *tp)
>  		usb_submit_urb(tp->intr_urb, GFP_NOIO);
>  	}
>  
> +	if (!test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> +		return 0;
> +
>  	/* If the device is RTL8152_INACCESSIBLE here then we should do a
>  	 * reset. This is important because the usb_lock_device_for_reset()
>  	 * that happens as a result of usb_queue_reset_device() will silently
>  	 * fail if the device was suspended or if too much time passed.
> -	 *
> -	 * NOTE: The device is locked here so we can directly do the reset.
> -	 * We don't need usb_lock_device_for_reset() because that's just a
> -	 * wrapper over device_lock() and device_resume() (which calls us)
> -	 * does that for us.
>  	 */
> -	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> -		usb_reset_device(tp->udev);
> +	if (test_bit(SELECTIVE_SUSPEND, &tp->flags))
> +		return usb_reset_device(tp->udev);
>  
> -	return 0;
> +	return -ENODEV;
>  }
>  
>  static int rtl8152_runtime_suspend(struct r8152 *tp)
> @@ -8674,6 +8672,14 @@ static int rtl8152_resume(struct usb_interface *intf)
>  
>  	mutex_unlock(&tp->control);
>  
> +	/*
> +	 * This only happens for !SELECTIVE_SUSPEND and RTL8152_INACCESSIBLE,
> +	 * drop tp->control, becuase reset can re-acquire it (e.g. from
> +	 * max address reset)
> +	 */
> +	if (ret == -ENODEV)
> +		ret = usb_reset_device(tp->udev);
> +
>  	return ret;
>  }

That's too messy.  Something like this should be better, I guess:

---

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 30f937527cd2..2cbc07b7aab5 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -8538,19 +8538,6 @@ static int rtl8152_system_resume(struct r8152 *tp)
 		usb_submit_urb(tp->intr_urb, GFP_NOIO);
 	}
 
-	/* If the device is RTL8152_INACCESSIBLE here then we should do a
-	 * reset. This is important because the usb_lock_device_for_reset()
-	 * that happens as a result of usb_queue_reset_device() will silently
-	 * fail if the device was suspended or if too much time passed.
-	 *
-	 * NOTE: The device is locked here so we can directly do the reset.
-	 * We don't need usb_lock_device_for_reset() because that's just a
-	 * wrapper over device_lock() and device_resume() (which calls us)
-	 * does that for us.
-	 */
-	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
-		usb_reset_device(tp->udev);
-
 	return 0;
 }
 
@@ -8661,6 +8648,7 @@ static int rtl8152_suspend(struct usb_interface *intf, pm_message_t message)
 static int rtl8152_resume(struct usb_interface *intf)
 {
 	struct r8152 *tp = usb_get_intfdata(intf);
+	bool system_resume = !test_bit(SELECTIVE_SUSPEND, &tp->flags);
 	int ret;
 
 	mutex_lock(&tp->control);
@@ -8674,6 +8662,9 @@ static int rtl8152_resume(struct usb_interface *intf)
 
 	mutex_unlock(&tp->control);
 
+	if (system_resume && test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+		ret = usb_reset_device(tp->udev);
+
 	return ret;
 }
 
