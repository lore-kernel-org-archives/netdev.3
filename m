Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB303495ACB
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790010955; cv=pass; b=qpIimf33jeizbCMG1L4P4zNpRxVSL77zssikpQYMv/42iOTo2baLQrjU1OEuU+axMgBD2jRt5uxoIpeevDRgf1R69DZ516++dDKva81PTLHoC0ujfbGI68emsLDDGAvS2DeA8j/sHhoN9jbeJ4MXTodia7M/i5kRDNT5xqWla4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790010955; c=relaxed/simple;
	bh=XNM09exsYegL0j8aXp10w/oxJLnSGVLJ5LkyzF8Ae1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxay6aPRsUyyK9kdGunvbS3Y2RuaNP+N19vjwoJas3uu6wPtIOo5Qdo9n+FLjcP8uweFWfCXvVocjrDfxn5h6pyPRqERCvZjmaGl9CXxz4yKHOPnO9hIbFb25vOPaYXvR/LZoc/6RursinbSs6lOVawvoY15nPIFxv6xZ0DHPOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kyPBAcxG; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kyPBAcxG"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49e6425f96eso1175e9.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 10:15:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790010952; cv=none;
        d=google.com; s=arc-20260327;
        b=bkPjGjRcfJnCqUwlVBSrOxG850OG/nHL5dVUMS5pJtbjM6XnsQoNQGME3FWJpzFFe5
         Fl1TsG9hYQIWP9YmFHMrxvEz4CRWhuAna1AoyCWGzPHrf3lhXuOVfBctgBpAsDPs41G+
         Tjh6vou1svqMFtD5Z5Q5VbWvM41v4x81UU10p6aDTlA4nWHxrPKc9XwXbWS0IopQ4sdK
         zkQcVHC6RzYqzs/r5tV9/5rb/FZb8ABonTG7+GFA0ajnWDsUK0ms2OqCQ3pYfk8H1qar
         v2NTq0PJaSsm42limOxNosChySOQyOqkHRmfMm/N0feI3XWqPDZlAXRYM4I7FlujYknw
         l51Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hhJiLPJ9nIrWDDTw2l/YgjEsqn8n/g/r+AQMTPn8I5E=;
        fh=//QHvyW8PShhtdJKUszOLYSUhquV9U7sw8rhGNWEodk=;
        b=huJv/khhc71WcpPodbsw/n02DbyL9ZTiH6VS3Oa4HuKfWTx0BX339fid7bzBDzuXAk
         DByCwE/hkOb1go8DWLWZ0DYhtka6pIbkJ/JhuE11sVlYcpD2sl+PKBVya3wOSQXGk2pt
         s6MMQvhpFDppxFEps/VAS4X+hOM+gaG2QY6TvOVKe74TgqSC8qfV6j9V6Dpes/YrUtcy
         l3v041XWyjRH7J4aLIWwdmgsFbxIccL4hPfP5dRKNmuKONfw8zg//4s8vBYLe2rpPX/7
         6V408KbUGm2sSS8sptmMTa+4acNOZUq6jNwAcEyKyTM4bMOppwStRDk34qrdkYYEGyFE
         ZIeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790010952; x=1790615752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hhJiLPJ9nIrWDDTw2l/YgjEsqn8n/g/r+AQMTPn8I5E=;
        b=kyPBAcxG0lW3PKMkrYKaLBU9cpWTesr0ya0qOjODtkwcsnnLLMSZC5xBDuohaw0zCg
         0Sof9UdblIJ1sZaYZn4+WfOLatbpnGhk5Vd1cUa1GNpYt4TuOFMYQKqLwg7q7jTfn6r/
         1RUfBjLWyI6qSWZILr7AAip/m3N8aw/Pex0FWwbwVyyVmJAV5LWNVi9UHdYreVek/C4S
         NSyTE05LbRSldTeyNvw9LO7XZwZUFYoAZZ2GKYTHTjMpKTCw4hfSENzDTkdjJrL8k4ST
         lGtHqCgTeYEDLGjeeNcTx9XM9A9WU2/VMgUmFvjeX0yCYl/1uLM7tDZKw7N46XgMEWil
         LfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790010952; x=1790615752;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hhJiLPJ9nIrWDDTw2l/YgjEsqn8n/g/r+AQMTPn8I5E=;
        b=bOcvVMKAjN0wf87bgOIWqzzxeIybV55MGG35Ey5VI8/pIb97SLvsdAQ5Q0SKtm75OX
         FI2NbKOw7GQEKtJbdx7FK48tH1peKZdM5QY4ZPqJJSjdTa/xkSRZRpy7XN0Z7uLRK6Q0
         tRLCvkk4bMm95/LxU7EbBGMunCckvrmtrsiMOhZw4YyYrrCpsbwYhsIrKM8QOc2kuU5K
         QOmmXdil+qS4dxMwbdLQYl8gOCdJFxrfw6jPvHywvJzJhK4qd54enGKrFYNgvF5PrK80
         SLVxWooeVz4M7Y0K5TsRBBm7RfwjZcvvvlnjqliPmxppbTlNbyMOdmvlIF3t/PHbVod+
         rWug==
X-Gm-Message-State: AFuF++no/Y2lhB13kPEIHSpBy2y1/RU/6OaPK7SunJCO06j56/AOTM/G
	6vpICUofYEj9dkA456wy9AFJwFWa7iCcwTDCvi8f4jL4JCdF7gqW4Rk+CYaTTfdv21b5g4q534b
	I9QnYfldhiqV4NnZiHOlPz2MwRbnvkzsDwFohP1iI
X-Gm-Gg: AYBFou1EtKAeGxgW24V0Rbbyc2D5ZPExVdPcyOuz6z60A5illkp85L2ozPZeMabgcov
	7wCS4T6rm8MzJVSLsvO/dCWvIbE+GPO9JJxf/I+YWv51y378nq/tRyhJ9ItFCFQyqg/7CvTis9b
	3NU71Z4MnKTgmtfg9j9ad3PFnaWSqS06arsX+b5uFjH0ik/qSP2NX63ChdfgFLkMnyvD7A7IwpT
	aIvilsaUUzwT2U/W0Wn53JMWCZTrKD/MkBd627VD6MQFi9dFwAitCuXIulyCzMRTgGrhsAm27Y7
	tGgB/CidJe8+SAVyDI2GSgXUWr76fkEOyIH5PjS/s06iDUmV8KI0chCztqhF1RYU88y9Bli3R0V
	JmoVR0mEaNQ==
X-Received: by 2002:a05:600c:6d55:b0:499:ad9c:97b5 with SMTP id
 5b1f17b1804b1-49fd91f5af8mr11805e9.12.1790010951067; Mon, 21 Sep 2026
 10:15:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918173413.3222413-1-namangulati@google.com> <20260919172817.7d8673ad@kernel.org>
In-Reply-To: <20260919172817.7d8673ad@kernel.org>
From: Naman Gulati <namangulati@google.com>
Date: Mon, 21 Sep 2026 10:15:39 -0700
X-Gm-Features: AcwNN1XuPYz2CLP-5GdPMqHlCWT1NELahVw-zWNBPRSq00_OiS-6muQg98JJLFo
Message-ID: <CAMP57yVWkD5rUXYQhqpdRYtiFWxggZ1yN6rnEzMDNYJSUVuMow@mail.gmail.com>
Subject: Re: [PATCH net] net: gro_cells: prevent enabling threaded NAPI on gro_cells
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, bigeasy@linutronix.de, kuniyu@google.com, 
	syzbot+f0661448aa9511ce744a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 5:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 18 Sep 2026 17:34:13 +0000 Naman Gulati wrote:
> >       NAPI_STATE_THREADED_BUSY_POLL,  /* The threaded NAPI poller will =
busy poll */
> > +     NAPI_STATE_NO_THREADED,         /* Threaded mode is not supported=
 */
>
> Adding state flags per entry point we want to prevent is pretty bad
> sw engineering :/ What's the property we're trying to express and
> isn't it effectively the same thing as NO_BUSY_POLL ?

napi can be configured to run in threaded mode without enabling
busypolling, that's the config we're explicitly trying to deny here
for netdevs that don't support it.

However that's a good point, I didn't realize specifying NO_BUSY_POLL
will prevent the napi from getting a unique ID. Netlink
NETDEV_CMD_NAPI_SET calls will already block this operation on the
gro_cells napi's as they won't have a unique id. Only the sysfs
interface would still allow enabling threaded napi on these netdevs.
Would it be better to piggy-back on this behavior and add something
like this check in modify_napi_threaded:

list_for_each_entry(napi, &dev->napi_list, dev_list) {
    if (napi_id_valid(napi->napi_id))
        return netif_set_threaded(dev, val);
}
